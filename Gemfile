source 'http://rubygems.org'

gem 'ruby-enum'
gem 'rubocop'
gem 'sandi_meter'

# Add dependencies to develop your gem here.
# Include everything needed to run rake, tests, features, etc.
group :development do
  gem 'rspec', '>= 3.0.0'
  gem 'rspec-core', '>= 3.0.0'

  # require to use Guard::RSpec::Formatter::NotificationRSpec
  gem 'rspec-legacy_formatters'

  gem 'yard'
  gem 'bundler', '~> 1.0'
  gem 'jeweler', '~> 2.0.1'
  gem 'simplecov', '>= 0'

  # Guard
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard-rspec', '>= 4.0.0'

  gem 'ripper-tags'
end

