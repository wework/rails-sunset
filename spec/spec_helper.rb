$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'coveralls'
require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  add_group 'lib', 'lib'
end

require 'rails/all'
require 'rails-sunset'
require 'rspec/rails'
require 'test_app/config/environment'

require 'spec_helper'
