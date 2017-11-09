# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_sunset/version'

Gem::Specification.new do |spec|
  spec.name          = "rails-sunset"
  spec.version       = RailsSunset::VERSION
  spec.authors       = ["WeWork Engineering"]
  spec.email         = ["engineering@wework.com"]

  spec.summary       = "Take out your trash endpoints"
  spec.description   = "Deprecate those endpoints you don't need anymore, without randomly deleting them and making everyone upset."
  spec.homepage      = "https://github.com/wework/rails-sunset-gem"
  spec.licenses      = ['MIT']

  spec.files                = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(spec)/})
  end
  spec.bindir               = "bin"
  spec.require_paths        = ["lib"]

  spec.add_dependency "rails", ">= 4.2", "< 6"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "rspec", ">= 3.6"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "simplecov"
end
