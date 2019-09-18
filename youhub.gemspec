# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'youhub/version'

Gem::Specification.new do |spec|
  spec.name          = 'youhub'
  spec.version       = Youhub::VERSION
  spec.authors       = ['Claudio Baccigalupo']
  spec.email         = ['claudio@fullscreen.net']
  spec.description   = 'Youtube V3 API client.'
  spec.summary       = 'Youhub makes it easy to interact with Youtube V3 API '\
                       'by providing a modular, intuitive and tested '\
                       'Ruby-style API.'
  spec.homepage      = 'http://github.com/CTZAR/youhub'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 2.5'

  spec.files         = `git ls-files`.split($RS)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport' # '3 (Ruby 1.9) or 4 (Ruby 2)'
  spec.add_dependency 'yt-support', '>= 0.1'

  # For development / Code coverage / Documentation
  spec.add_development_dependency 'bundler' # , '~> 1.0'
  spec.add_development_dependency 'coveralls' # , '~> 0.7.0'
  spec.add_development_dependency 'rake' # , '~> 10.0'
  spec.add_development_dependency 'rspec' # , '~> 2.0'
  spec.add_development_dependency 'yard' # , '~> 0.8.0'
end
