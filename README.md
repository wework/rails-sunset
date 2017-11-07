# Rails Sunset

[![Build Status][travis-image]][travis-url]
[![Coverage Status][coveralls-image]][coveralls-url]
[![MIT License][license-image]][license-url]

Rails Sunset lets you create deprecation headers in a Railsy way, using the [Sunset][sunset-draft] header. The Sunset header is an in-development HTTP response header that helps you mark endpoints as going away.

Why? Because we all have those trash endpoints we'd love to delete, but you can't just delete them without causing a full on garbage fire.

![Take out the garbage](https://user-images.githubusercontent.com/67381/32471240-46bc2786-c32a-11e7-8d0b-903ade85413b.jpeg)

> This specification defines the Sunset HTTP response header field, which indicates that a URI is likely to become unresponsive at a specified point in the future.

[sunset-draft]: https://tools.ietf.org/html/draft-wilde-sunset-header-03

When output, it looks like this:

```
Sunset: Sat, 31 Dec 2018 23:59:59 GMT
```

## Usage

```ruby
gem 'rails-sunset'
```

Using it in your controllers is as simple as calling the sunset class method:

``` ruby
class FooController
  # Deprecate all methods and point them to a blog post
  sunset DateTime.new(2019, 1, 1), link: 'http://example.com/blog/get-them-foos-outta-here'

  # Deprecate two and point to their new resources, but do it via only: []
  sunset DateTime.new(2019, 1, 1), link: api_v3_companies, only: [:index]
  sunset DateTime.new(2019, 1, 1), link: ->(){ api_v3_company(params['id']) }, only: [:show]

  # Maybe we should add sunset_method for that?
  sunset_method :index, DateTime.new(2019, 1, 1), link: api_v3_companies
  sunset_method :show, DateTime.new(2019, 1, 1), link: ->(){ api_v3_company(params['id']) }
end
```

These deprecations are logged to the `Rails.logger`, and output with `ActiveSupport::Deprecation`. You can [configure `ActiveSupport::Deprecation`][active-support-deprecation] to warn in a few different ways, or pass in any object that acts a bit like a Rack logger, Rails logger, or anything with a `warn` method that takes a string.

[active-support-deprecation]: http://api.rubyonrails.org/classes/ActiveSupport/Deprecation/Behavior.html

## Requirements

- **Ruby:** v2.2 - v2.4
- **Rails:** v4.2 - v5.2

## Testing

To run tests and modify locally, you'll want to `bundle install` in this directory.

```
bundle exec appraisal rspec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at [wework/rails-sunset](https://github.com/wework/rails-sunset). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


[coveralls-image]:https://coveralls.io/repos/github/wework/rails-sunset/badge.svg?branch=master
[coveralls-url]:https://coveralls.io/github/wework/rails-sunset?branch=master

[travis-url]:https://travis-ci.org/wework/rails-sunset
[travis-image]: https://travis-ci.org/wework/rails-sunset.svg?branch=master

[license-url]: LICENSE
[license-image]: http://img.shields.io/badge/license-MIT-000000.svg?style=flat-square
