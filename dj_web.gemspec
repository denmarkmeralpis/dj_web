$:.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'dj_web/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'dj_web'
  spec.version     = DjWeb::VERSION
  spec.authors     = ['Nujian Den Mark Meralpis']
  spec.email       = ['denmarkmeralpis@gmail.com']
  spec.homepage    = 'https://github.com/denmarkmeralpis/dj_web'
  spec.summary     = 'A rails mountable engine for DelayedJob management.'
  spec.description = 'Web-based DelayedJob management.'
  spec.license     = 'MIT'
  spec.files       = Dir[
    "{app,config,db,lib}/**/*", 'MIT-LICENSE', 'Rakefile', 'README.md'
  ]
  spec.add_dependency 'rails', '~> 5.2.4', '>= 5.2.4.5'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'spring'
  spec.add_development_dependency 'spring-commands-rspec'
  spec.add_runtime_dependency 'delayed_job_active_record'
  spec.add_development_dependency 'mysql2'
  spec.add_dependency 'bootstrap', '~> 4.1.1'
  spec.add_dependency 'sassc-rails'
  spec.add_dependency 'tabler-rubygem'
  spec.add_development_dependency 'factory_bot_rails'
  spec.add_development_dependency 'rails-controller-testing'
  spec.add_development_dependency 'shoulda-callback-matchers', '~> 1.1.1'
  spec.add_development_dependency 'shoulda-matchers'
  spec.add_dependency 'will_paginate'
end
