# frozen_string_literal: true

module Youhub
  module Associations
    # @private
    # Provides authentication methods to YouTube resources, which allows to
    # access to content detail set-specific methods like `access_token`.
    #
    # YouTube resources with authentication are: {Youhub::Models::Account accounts}.
    module HasAuthentication
      def has_authentication
        require 'youhub/collections/authentications'
        require 'youhub/collections/device_flows'
        require 'youhub/collections/revocations'
        require 'youhub/errors/missing_auth'
        require 'youhub/errors/no_items'
        require 'youhub/errors/unauthorized'

        include Associations::Authenticable
      end
    end

    # @private
    module Authenticable
      delegate :access_token, :refresh_token, :expires_at, to: :authentication

      def initialize(options = {})
        @access_token = options[:access_token]
        @refresh_token = options[:refresh_token]
        @device_code = options[:device_code]
        @expires_at = options[:expires_at]
        @authorization_code = options[:authorization_code]
        @redirect_uri = options[:redirect_uri]
        @force = options[:force]
        @scopes = options[:scopes]
        @authentication = options[:authentication]
      end

      def auth
        self
      end

      def authentication
        @authentication = current_authentication
        @authentication ||= use_refresh_token! if @refresh_token
        @authentication ||= use_authorization_code! if @authorization_code
        @authentication ||= use_device_code! if @device_code
        @authentication ||= raise_missing_authentication!
      end

      def authentication_url
        host = 'accounts.google.com'
        path = '/o/oauth2/auth'
        query = authentication_url_params.to_param
        URI::HTTPS.build(host: host, path: path, query: query).to_s
      end

      # Obtains a new access token.
      # Returns true if the new access token is different from the previous one
      def refreshed_access_token?
        old_access_token = authentication.access_token
        @authentication = @access_token = @refreshed_authentications = nil

        if old_access_token != authentication.access_token
          access_token_was_refreshed
          true
        else
          false
        end
      end

      # Revoke access given to the application.
      # Returns true if the access was correctly revoked.
      # @see https://developers.google.com/identity/protocols/OAuth2WebServer#tokenrevoke
      def revoke_access
        revocations.first!
        @authentication = @access_token = @refreshed_authentications = nil
        true
      rescue Errors::RequestError => e
        raise unless e.reasons.include? 'invalid_token'

        false
      end

      # Invoked when the access token is refreshed.
      def access_token_was_refreshed
        # Apps using Youhub can override this method to handle this event, for
        # instance to store the newly generated access token in the database.
      end

      private

      def current_authentication
        @authentication ||= Youhub::Authentication.new current_data if @access_token
        @authentication unless @authentication.nil? || @authentication.expired?
      end

      def current_data
        {}.tap do |data|
          data['access_token'] = @access_token
          data['expires_at'] = @expires_at
          data['refresh_token'] = @refresh_token
        end
      end

      # Tries to obtain an access token using the authorization code (which
      # can only be used once). On failure, raise an error.
      def use_authorization_code!
        new_authentications.first!
      rescue Errors::NoItems => e
        raise Errors::Unauthorized, e.to_param
      end

      # Tries to obtain an access token using the refresh token (which can
      # be used multiple times). On failure, raise an error.
      def use_refresh_token!
        refreshed_authentications.first!
      rescue Errors::NoItems => e
        raise Errors::Unauthorized, e.to_param
      end

      # Tries to obtain an access token using the device code (which must be
      # confirmed by the user with the user_code). On failure, raise an error.
      def use_device_code!
        device_code_authentications.first!.tap do |auth|
          raise Errors::MissingAuth, pending_device_code_message if auth.pending?
        end
      end

      def raise_missing_authentication!
        error_message = if @redirect_uri && @scopes then missing_authorization_code_message
                        elsif @scopes then pending_device_code_message
                        else {}
        end
        raise Errors::MissingAuth, error_message
      end

      def pending_device_code_message
        @device_flow ||= device_flows.first!
        @device_code ||= @device_flow.device_code
        {}.tap do |params|
          params[:scopes] = @scopes
          params[:user_code] = @device_flow.user_code
          params[:verification_url] = @device_flow.verification_url
        end
      end

      def missing_authorization_code_message
        {}.tap do |params|
          params[:scopes] = @scopes
          params[:authentication_url] = authentication_url
          params[:redirect_uri] = @redirect_uri
        end
      end

      def new_authentications
        @new_authentications ||= Collections::Authentications.of(self).tap do |auth|
          auth.auth_params = new_authentication_params
        end
      end

      def refreshed_authentications
        @refreshed_authentications ||= Collections::Authentications.of(self).tap do |auth|
          auth.auth_params = refreshed_authentication_params
        end
      end

      def device_code_authentications
        Collections::Authentications.of(self).tap do |auth|
          auth.auth_params = device_code_authentication_params
        end
      end

      def device_flows
        @device_flows ||= Collections::DeviceFlows.of(self).tap do |auth|
          auth.auth_params = device_flow_params
        end
      end

      def revocations
        @revocations ||= Collections::Revocations.of(self).tap do |auth|
          auth.auth_params = { token: @refresh_token || @access_token }
        end
      end

      def authentication_url_params
        {}.tap do |params|
          params[:client_id] = client_id
          params[:scope] = authentication_scope
          params[:redirect_uri] = @redirect_uri
          params[:response_type] = :code
          params[:access_type] = :offline
          params[:approval_prompt] = @force ? :force : :auto
          # params[:include_granted_scopes] = true
        end
      end

      def authentication_scope
        if @scopes.is_a?(Array)
          @scopes.map do |scope|
            "https://www.googleapis.com/auth/#{scope}"
          end.join(' ')
        end
      end

      def new_authentication_params
        {}.tap do |params|
          params[:client_id] = client_id
          params[:client_secret] = client_secret
          params[:code] = @authorization_code
          params[:redirect_uri] = @redirect_uri
          params[:grant_type] = :authorization_code
        end
      end

      def refreshed_authentication_params
        {}.tap do |params|
          params[:client_id] = client_id
          params[:client_secret] = client_secret
          params[:refresh_token] = @refresh_token
          params[:grant_type] = :refresh_token
        end
      end

      def device_code_authentication_params
        {}.tap do |params|
          params[:client_id] = client_id
          params[:client_secret] = client_secret
          params[:code] = @device_code
          params[:grant_type] = 'http://oauth.net/grant_type/device/1.0'
        end
      end

      def device_flow_params
        {}.tap do |params|
          params[:client_id] = client_id
          params[:scope] = authentication_scope
        end
      end

      def client_id
        Youhub.configuration.client_id
      end

      def client_secret
        Youhub.configuration.client_secret
      end
    end
  end
end
