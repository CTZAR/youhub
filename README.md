Youhub - a Ruby client for the YouTube API
======================================================

Youhub helps you write apps that need to interact with YouTube.

The **source code** is available on [GitHub](https://github.com/Fullscreen/youhub) and the **documentation** on [RubyDoc](http://www.rubydoc.info/gems/youhub/frames).

[![Build Status](http://img.shields.io/travis/Fullscreen/youhub/master.svg)](https://travis-ci.org/Fullscreen/youhub)
[![Coverage Status](http://img.shields.io/coveralls/Fullscreen/youhub/master.svg)](https://coveralls.io/r/Fullscreen/youhub)
[![Dependency Status](http://img.shields.io/gemnasium/Fullscreen/youhub.svg)](https://gemnasium.com/Fullscreen/youhub)
[![Code Climate](http://img.shields.io/codeclimate/github/Fullscreen/youhub.svg)](https://codeclimate.com/github/Fullscreen/youhub)
[![Online docs](http://img.shields.io/badge/docs-✓-green.svg)](http://www.rubydoc.info/gems/youhub/frames)
[![Gem Version](http://img.shields.io/gem/v/youhub.svg)](http://rubygems.org/gems/youhub)

After [registering your app](#configuring-your-app), you can run commands like:

```ruby
channel = Youhub::Channel.new id: 'UCxO1tY8h1AhOz0T4ENwmpow'
channel.title #=> "Fullscreen"
channel.public? #=> true
channel.comment_count #=> 773
channel.videos.count #=> 12
```

```ruby
video = Youhub::Video.new id: 'jNQXAC9IVRw'
video.title #=> "Fullscreen Creator Platform"
video.comment_count #=> 308
video.hd? #=> true
video.annotations.count #=> 1
video.comment_threads #=> #<Youhub::Collections::CommentThreads ...>
# Use #take to limit the number of pages need to fetch from server
video.comment_threads.take(99).map(&:author_display_name) #=> ["Paul", "Tommy", ...]
```

The **full documentation** is available at [rubydoc.info](http://www.rubydoc.info/gems/youhub/frames).

How to install
==============

To install on your system, run

    gem install youhub

To use inside a bundled Ruby project, add this line to the Gemfile:

    gem 'youhub', '~> 0.28.0'

Since the gem follows [Semantic Versioning](http://semver.org),
indicating the full version in your Gemfile (~> *major*.*minor*.*patch*)
guarantees that your project won’t occur in any error when you `bundle update`
and a new version of Youhub is released.

Available resources
===================

Youhub::Account
-----------

Check [fullscreen.github.io/youhub](http://fullscreen.github.io/youhub/accounts.html) for the list of methods available for `Youhub::Account`.


Youhub::ContentOwner
----------------

Use [Youhub::ContentOwner](http://www.rubydoc.info/gems/youhub/Youhub/Models/ContentOwner) to:

* authenticate as a YouTube content owner
* list the channels partnered with a YouTube content owner
* list the claims administered by the content owner
* list and delete the references administered by the content owner
* list the policies and policy rules administered by the content owner
* create assets
* list assets

```ruby
# Content owners can be initialized with access token, refresh token or an authorization code
content_owner = Youhub::ContentOwner.new owner_name: 'CMSname', access_token: 'ya29.1.ABCDEFGHIJ'

content_owner.partnered_channels.count #=> 12
content_owner.partnered_channels.map &:title #=> ["Fullscreen", "Best of Fullscreen", ...]
content_owner.partnered_channels.where(part: 'statistics').map &:subscriber_count #=> [136925, 56945, ...]

content_owner.claims.where(q: 'Fullscreen').count #=> 24
content_owner.claims.first #=> #<Youhub::Models::Claim @id=...>
content_owner.claims.first.video_id #=> 'jNQXAC9IVRw'
content_owner.claims.first.status #=> "active"

reference = content_owner.references.where(asset_id: "ABCDEFG").first #=> #<Youhub::Models::Reference @id=...>
reference.delete #=> true

content_owner.policies.first #=> #<Youhub::Models::Policy @id=...>
content_owner.policies.first.name #=> "Track in all countries"
content_owner.policies.first.rules.first #=> #<Youhub::Models::PolicyRule @id=...>
content_owner.policies.first.rules.first.action #=> "monetize"
content_owner.policies.first.rules.first.included_territories #=> ["US", "CA"]

content_owner.create_asset type: 'web' #=> #<Youhub::Models::Asset @id=...>

content_owner.assets.first #=> #<Youhub::Models::AssetSnippet:0x007ff2bc543b00 @id=...>
content_owner.assets.first.id #=> "A4532885163805730"
content_owner.assets.first.title #=> "Money Train"
content_owner.assets.first.type #=> "web"
content_owner.assets.first.custom_id #=> "MoKNJFOIRroc"

```

*All the above methods require authentication (see below).*

Youhub::Channel
-----------

Check [fullscreen.github.io/youhub](http://fullscreen.github.io/youhub/channels.html) for the list of methods available for `Youhub::Channel`.

Youhub::Video
---------

Check [fullscreen.github.io/youhub](http://fullscreen.github.io/youhub/videos.html) for the list of methods available for `Youhub::Video`.

Youhub::Playlist
------------

Check [fullscreen.github.io/youhub](http://fullscreen.github.io/youhub/playlists.html) for the list of methods available for `Youhub::Playlist`.

Youhub::PlaylistItem
----------------

Check [fullscreen.github.io/youhub](http://fullscreen.github.io/youhub/playlist_items.html) for the list of methods available for `Youhub::PlaylistItem`.

Youhub::CommentThread
----------------

Use [Youhub::CommentThread](http://www.rubydoc.info/gems/youhub/Youhub/Models/CommentThread) to:

* Show details of a comment_thread.

```ruby
Youhub::CommentThread.new id: 'z13vsnnbwtv4sbnug232erczcmi3wzaug'

comment_thread.video_id #=> "1234"
comment_thread.total_reply_count #=> 1
comment_thread.can_reply? #=> true
comment_thread.public? #=> true

comment_thread.top_level_comment #=> #<Youhub::Models::Comment ...>
comment_thread.text_display #=> "funny video!"
comment_thread.like_count #=> 9
comment_thread.updated_at #=> 2016-03-22 12:56:56 UTC
comment_thread.author_display_name #=> "Joe"
```

Youhub::Comment
----------------

Use [Youhub::Comment](http://www.rubydoc.info/gems/youhub/Youhub/Models/Comment) to:

* Get details of a comment.

```ruby
Youhub::Comment.new id: 'z13vsnnbwtv4sbnug232erczcmi3wzaug'

comment.text_display #=> "awesome"
comment.author_display_name #=> "Jack"
comment.like_count #=> 1
comment.updated_at #=> 2016-03-22 12:56:56 UTC
comment.parent_id #=> "abc1234" (return nil if the comment is not a reply)
```

Youhub::BulkReportJob
----------------

Use [Youhub::BulkReportJob](http://www.rubydoc.info/gems/youhub/Youhub/Models/BulkReportJob) to:

* Get details of a bulk report job.

```ruby
content_owner = Youhub::ContentOwner.new owner_name: 'CMSname', access_token: 'ya29.1.ABCDEFGHIJ'
bulk_report_job = content_owner.bulk_report_jobs.first

bulk_report_job.report_type_id #=> "content_owner_demographics_a1"
```

Youhub::BulkReport
----------------

Use [Youhub::BulkReport](http://www.rubydoc.info/gems/youhub/Youhub/Models/BulkReport) to:

* Get details of a bulk report.

```ruby
content_owner = Youhub::ContentOwner.new owner_name: 'CMSname', access_token: 'ya29.1.ABCDEFGHIJ'
bulk_report_job = content_owner.bulk_report_jobs.first
bulk_report = bulk_report_job.bulk_reports.first

bulk_report.start_time #=> 2017-08-11 07:00:00 UTC
bulk_report.end_time #=> 2017-08-12 07:00:00 UTC
bulk_report.download_url #=> "https://youtubereporting.googleapis.com/v1/..."
```

Youhub::Collections::Videos
-----------------------

Use [Youhub::Collections::Videos](http://www.rubydoc.info/gems/youhub/Youhub/Collections/Videos) to:

* search for videos

```ruby
videos = Youhub::Collections::Videos.new
videos.where(order: 'viewCount').first.title #=>  "PSY - GANGNAM STYLE"
videos.where(q: 'Fullscreen CreatorPlatform', safe_search: 'none').size #=> 324
videos.where(chart: 'mostPopular', video_category_id: 44).first.title #=> "SINISTER - Trailer"
videos.where(id: 'jNQXAC9IVRw,invalid').map(&:title) #=> ["Fullscreen Creator Platform"]
```

*The methods above do not require authentication.*


Youhub::Annotation
--------------

Check [fullscreen.github.io/youhub](http://fullscreen.github.io/youhub/annotations.html) for the list of methods available for `Youhub::Annotation`.


Youhub::MatchPolicy
---------------

Use [Youhub::MatchPolicy](http://www.rubydoc.info/gems/youhub/Youhub/Models/MatchPolicy) to:

* update the policy used by an asset

```ruby
content_owner = Youhub::ContentOwner.new owner_name: 'CMSname', access_token: 'ya29.1.ABCDEFGHIJ'
match_policy = Youhub::MatchPolicy.new asset_id: 'ABCD12345678', auth: content_owner
match_policy.update policy_id: 'aBcdEF6g-HJ' #=> true
```

Youhub::Asset
---------

Use [Youhub::Asset](http://www.rubydoc.info/gems/youhub/Youhub/Models/Asset) to:

* read the ownership of an asset
* update the attributes of an asset

```ruby

content_owner = Youhub::ContentOwner.new owner_name: 'CMSname', access_token: 'ya29.1.ABCDEFGHIJ'
asset = Youhub::Asset.new id: 'ABCD12345678', auth: content_owner
asset.ownership #=> #<Youhub::Models::Ownership @general=...>
asset.ownership.obtain! #=> true
asset.general_owners.first.owner #=> 'CMSname'
asset.general_owners.first.everywhere? #=> true
asset.ownership.release! #=> true

asset.update metadata_mine: {notes: 'Some notes'} #=> true
```

* to retrieve metadata for an asset (e.g. title, notes, description, custom_id)

```ruby
content_owner = Youhub::ContentOwner.new(...)
asset = content_owner.assets.where(id: 'A969176766549462', fetch_metadata: 'mine').first
asset.metadata_mine.title #=> "Master Final   Neu La Anh Fix"

asset = content_owner.assets.where(id: 'A969176766549462', fetch_metadata: 'effective').first
asset.metadata_effective.title #=> "Neu la anh" (different due to ownership conflicts)
```

* to search for an asset

```ruby
content_owner.assets.where(labels: "campaign:cpiuwdz-8oc").size #=> 417
content_owner.assets.where(labels: "campaign:cpiuwdz-8oc").first.title #=> "Whoomp! (Supadupafly) (Xxl Hip House Mix)"
```

Youhub::Claim
---------

Use [Youhub::Claim](http://www.rubydoc.info/gems/youhub/Youhub/Models/Claim) to:

* read the attributes of a claim
* view the history of a claim
* update the attributes of an claim

```ruby

content_owner = Youhub::ContentOwner.new owner_name: 'CMSname', access_token: 'ya29.1.ABCDEFGHIJ'
claim = Youhub::Claim.new id: 'ABCD12345678', auth: content_owner
claim.video_id #=> 'va141cJga2'
claim.asset_id #=> 'A1234'
claim.content_type #=> 'audiovisual'
claim.active? #=> true

claim.claim_history #=> #<Youhub::Models::ClaimHistory ...>
claim.claim_history.events[0].type #=> "claim_create"

claim.delete #=> true
```

*The methods above require to be authenticated as the video’s content owner (see below).*

Youhub::Ownership
-------------

Use [Youhub::Ownership](http://www.rubydoc.info/gems/youhub/Youhub/Models/Ownership) to:

* update the ownership of an asset

```ruby
content_owner = Youhub::ContentOwner.new owner_name: 'CMSname', access_token: 'ya29.1.ABCDEFGHIJ'
ownership = Youhub::Ownership.new asset_id: 'ABCD12345678', auth: $content_owner
new_general_owner_attrs = {ratio: 100, owner: 'CMSname', type: 'include', territories: ['US', 'CA']}
ownership.update general: [new_general_owner_attrs]
```

*The methods above require to be authenticated as the video’s content owner (see below).*

Youhub::AdvertisingOptionsSet
-------------------------

Use [Youhub::AdvertisingOptionsSet](http://www.rubydoc.info/gems/youhub/Youhub/Models/AdvertisingOptionsSet) to:

* update the advertising settings of a video

```ruby
content_owner = Youhub::ContentOwner.new owner_name: 'CMSname', access_token: 'ya29.1.ABCDEFGHIJ'
ad_options = Youhub::AdvertisingOptionsSet.new video_id: 'jNQXAC9IVRw', auth: $content_owner
ad_options.update ad_formats: %w(standard_instream long) #=> true
```

*The methods above require to be authenticated as the video’s content owner (see below).*

Instrumentation
===============

Youhub leverages [Active Support Instrumentation](http://edgeguides.rubyonrails.org/active_support_instrumentation.html) to provide a hook which developers can use to be notified when HTTP requests to YouTube are made.  This hook may be used to track the number of requests over time, monitor quota usage, provide an audit trail, or track how long a specific request takes to complete.

Subscribe to the `request.youhub` notification within your application:

```ruby
ActiveSupport::Notifications.subscribe 'request.youhub' do |*args|
  event = ActiveSupport::Notifications::Event.new(*args)

  event.payload[:request_uri] #=> #<URI::HTTPS URL:https://www.googleapis.com/youtube/v3/channels?id=UCxO1tY8h1AhOz0T4ENwmpow&part=snippet>
  event.payload[:method] #=> :get
  event.payload[:response] #=> #<Net::HTTPOK 200 OK readbody=true>

  event.end #=> 2014-08-22 16:57:17 -0700
  event.duration #=> 141.867 (ms)
end
```

Configuring your app
====================

In order to use Youhub you must register your app in the [Google Developers Console](https://console.developers.google.com).

If you don’t have a registered app, browse to the console and select "Create Project":
![01-create-project](https://cloud.githubusercontent.com/assets/7408595/3373043/4224c894-fbb0-11e3-9f8a-4d96bddce136.png)

When your project is ready, select APIs & Auth in the menu and individually enable Google+, YouTube Analyouhubics and YouTube Data API:
![02-select-api](https://cloud.githubusercontent.com/assets/4453997/8442701/5d0f77f4-1f35-11e5-93d8-07d4459186b5.png)
![02a-enable google api](https://cloud.githubusercontent.com/assets/4453997/8442306/0f714cb8-1f33-11e5-99b3-f17a4b1230fe.png)
![02b-enable youtube api](https://cloud.githubusercontent.com/assets/4453997/8442304/0f6fd0e0-1f33-11e5-981a-acf90ccd7409.png)
![02c-enable youtube analyouhubics api](https://cloud.githubusercontent.com/assets/4453997/8442305/0f71240e-1f33-11e5-9b60-4ecea02da9be.png)

The next step is to create an API key. Depending on the nature of your app, you should pick one of the following strategies.

Apps that do not require user interactions
------------------------------------------

If you are building a read-only app that fetches public data from YouTube, then
all you need is a **Public API access**.

Click on "Create new Key" in the Public API section and select "Server Key":
![03-create-key](https://cloud.githubusercontent.com/assets/7408595/3373045/42258fcc-fbb0-11e3-821c-699c8a3ce7bc.png)
![04-create-server-key](https://cloud.githubusercontent.com/assets/7408595/3373044/42251db2-fbb0-11e3-93f9-8f06f8390b4e.png)

Once the key for server application is created, copy the API key and add it
to your code with the following snippet of code (replacing with your own key):

```ruby
Youhub.configure do |config|
  config.api_key = 'AIzaSyAO8dXpvZcaP2XSDFBD91H8yQ'
end
```

Remember: this kind of app is not allowed to perform any destructive operation,
so you won’t be able to like a video, subscribe to a channel or delete a
playlist from a specific account. You will only be able to retrieve read-only
data.

Web apps that require user interactions
---------------------------------------

If you are building a web app that manages YouTube accounts, you need the
owner of each account to authorize your app. There are three scenarios:

Scenario 1. If you already have the account’s **access token**, then you are ready to go.
Just pass that access token to the account initializer, such as:

```ruby
account = Youhub::Account.new access_token: 'ya29.1.ABCDEFGHIJ'
account.email #=> (retrieves the account’s e-mail address)
account.videos #=> (lists a video to an account’s playlist)
```

Scenario 2. If you don’t have the account’s access token, but you have the
**refresh token**, then it’s almost as easy.
In the [Google Developers Console](https://console.developers.google.com),
find the web application that was used to obtain the refresh token, copy the
Client ID and Client secret and add them to you code with the following snippet
of code (replacing with your own keys):

```ruby
Youhub.configure do |config|
  config.client_id = '1234567890.apps.googleusercontent.com'
  config.client_secret = '1234567890'
end
```
Then you can manage a YouTube account by passing the refresh token to the
account initializer, such as:

```ruby
account = Youhub::Account.new refresh_token: '1/1234567890'
account.email #=> (retrieves the account’s e-mail address)
account.videos #=> (lists a video to an account’s playlist)
```

Scenario 3. If you don’t have any account’s token, then you can get one by
having the user authorize your app through the Google OAuth page.

In the [Google Developers Console](https://console.developers.google.com),
click on "Create new Client ID" in the OAuth section and select "Web application":
![06-create-client-key](https://cloud.githubusercontent.com/assets/7408595/3373047/42379eba-fbb0-11e3-89c4-16b10e072de6.png)

Fill the "Authorized Redirect URI" textarea with the URL of your app where you
want to redirect users after they authorize their YouTube account.

Once the Client ID for web application is created, copy the Client ID and secret
and add them to your code with the following snippet of code (replacing with your own keys):

```ruby
Youhub.configure do |config|
  config.client_id = '49781862760-4t610gtk35462g.apps.googleusercontent.com'
  config.client_secret = 'NtFHjZkJcwYZDfYVz9mp8skz9'
end
```

Finally, in your web app, add a link to the URL generated by running

```ruby
Youhub::Account.new(scopes: scopes, redirect_uri: redirect_uri).authentication_url
```

where `redirect_uri` is the URL you entered in the form above, and `scopes` is
the list of YouTube scopes you want the user to authorize. Depending on the
nature of your app, you can pick one or more among `youtube`, `youtube.readonly` `userinfo.email`.

Every user who authorizes your app will be redirected to the `redirect_uri`
with an extra `code` parameter that looks something like `4/Ja60jJ7_Kw0`.
Just pass the code to the following method to authenticate and initialize the account:

```ruby
account = Youhub::Account.new authorization_code: '4/Ja60jJ7_Kw0', redirect_uri: redirect_uri
account.email #=> (retrieves the account’s e-mail address)
account.videos #=> (lists a video to an account’s playlist)
```

Configuring with environment variables
--------------------------------------

As an alternative to the approach above, you can configure your app with
variables. Setting the following environment variables:

```bash
export YOUHUB_CLIENT_ID="1234567890.apps.googleusercontent.com"
export YOUHUB_CLIENT_SECRET="1234567890"
export YOUHUB_API_KEY="123456789012345678901234567890"
```

is equivalent to configuring your app with the initializer:

```ruby
Youhub.configure do |config|
  config.client_id = '1234567890.apps.googleusercontent.com'
  config.client_secret = '1234567890'
  config.api_key = '123456789012345678901234567890'
end
```

so use the approach that you prefer.
If a variable is set in both places, then `Youhub.configure` takes precedence.

Why you should use Youhub…
======================

… and not [youtube_it](https://github.com/kylejginavan/youtube_it)?
Because youtube_it does not support YouTube API V3, and the YouTube API V2 has
been [officially deprecated as of March 4, 2014](https://developers.google.com/youtube/2.0/developers_guide_protocol_audience).
If you need help upgrading your code, check [YOUTUBE_IT.md](https://github.com/Fullscreen/youhub/blob/master/YOUTUBE_IT.md),
a step-by-step comparison between youtube_it and Youhub to make upgrade easier.

… and not [Google Api Client](https://github.com/google/google-api-ruby-client)?
Because Google Api Client is poorly coded, poorly documented and adds many
dependencies, bloating the size of your project.

… and not your own code? Because Youhub is fully tested, well documented,
has few dependencies and helps you forget about the burden of dealing with
Google API!

How to test
===========

Youhub comes with two different sets of tests:

1. tests in `spec/models`, `spec/collections` and `spec/errors` **do not hit** the YouTube API
1. tests in `spec/requests` **hit** the YouTube API and require authentication

The reason why some tests actually hit the YouTube API is because they are
meant to really integrate Youhub with YouTube. YouTube API is not exactly
*the most reliable* API out there, so we need to make sure that the responses
match the documentation.

You don’t have to run all the tests every time you change code.
Travis CI is already set up to do this for when whenever you push a branch
or create a pull request for this project.

To only run tests against models, collections and errors (which do not hit the API), type:

```bash
rspec spec/models spec/collections spec/errors
```

To also run live-tests against the YouTube API, type:

```bash
rspec
```

This will fail unless you have set up a test YouTube application and some
tests YouTube accounts to hit the API. Once again, you probably don’t need
this, since Travis CI already takes care of running this kind of tests.

How to release new versions
===========================

If you are a manager of this project, remember to upgrade the [Youhub gem](http://rubygems.org/gems/youhub)
whenever a new feature is added or a bug gets fixed.

Make sure all the tests are passing on [Travis CI](https://travis-ci.org/Fullscreen/youhub),
document the changes in CHANGELOG.md and README.md, bump the version, then run

    rake release

Remember that the youhub gem follows [Semantic Versioning](http://semver.org).
Any new release that is fully backward-compatible should bump the *patch* version (0.0.x).
Any new version that breaks compatibility should bump the *minor* version (0.x.0)

How to contribute
=================

Youhub needs your support!
The goal of Youhub is to provide a Ruby interface for all the methods exposed by
the [YouTube Data API (v3)](https://developers.google.com/youtube/v3) and by
the [YouTube Analyouhubics API](https://developers.google.com/youtube/analyouhubics).

If you find that a method is missing, fork the project, add the missing code,
write the appropriate tests, then submit a pull request, and it will gladly
be merged!
