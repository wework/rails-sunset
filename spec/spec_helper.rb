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

require 'spec_helper'
