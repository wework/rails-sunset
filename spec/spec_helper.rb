$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'coveralls'
require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
])
SimpleCov.start do
  add_group 'lib', 'lib'
end

require 'test_app/config/environment'
require 'rspec/rails'
require 'rails-sunset'

def send_request(http_method, method, params)
  if Rails::VERSION::MAJOR == 4
    send http_method, method, **params
  else
    send http_method, method, params: params
  end
end
