source 'https://rubygems.org'
gem 'rake'
gem 'sinatra-flash', :require => 'sinatra/flash'

gem 'haml'

gem 'dm-validations'
gem 'dm-timestamps'
gem 'dm-migrations'
gem 'dm-constraints'
gem 'dm-aggregates'
gem 'dm-serializer'
gem 'dm-core'
gem 'multi_json'

# Test requirements

gem 'padrino-multi-json'
gem 'padrino'

group :test do
  gem 'rspec'
  gem 'rack-test', :require => "rack/test"
end

group :development, :test do
  gem 'dm-sqlite-adapter'
end

group :production do
  gem 'dm-postgres-adapter'
end
