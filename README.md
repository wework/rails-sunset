# Rails Sunset

[![Build Status][travis-image]][travis-url]
[![Coverage Status][coveralls-image]][coveralls-url]
[![MIT License][license-image]][license-url]

Rails Sunset lets you deprecate URLs (API or otherwise) in a Railsy way. Why? Because we all have those trash endpoints we'd love to delete, but we can't just delete them without turning that trash into a full-on garbage fire.

![Take out the garbage](https://user-images.githubusercontent.com/67381/32471240-46bc2786-c32a-11e7-8d0b-903ade85413b.jpeg)

The [Sunset header][sunset-draft] is an in-development HTTP response header that is aiming to standardize how URLs are marked for deprecation. tl:dr; it looks a bit like this:

```
Sunset: Sat, 31 Dec 2018 23:59:59 GMT
```

This can be combined with a `Link: <http://foo.com/something> rel="sunset"` which can be anything that might help a developer know what is going on. Maybe link to your API documentation for the new resource, the OpenAPI/JSON Schema definitions, or even a blog post explaining the change.

[sunset-draft]: https://tools.ietf.org/html/draft-wilde-sunset-header-03

## Usage

```ruby
gem 'rails-sunset'
```

Using it in your controllers is as simple as calling the sunset class method:

``` ruby
class FooController
  # Deprecate all methods and point them to a blog post
  sunset DateTime.new(2019, 1, 1), link: 'http://example.com/blog/get-them-foos-outta-here'

  # Deprecate only update and destroy but dont explain why
  sunset DateTime.new(2019, 1, 1), only: [:update, :destroy]

  # Deprecate just the one method with this shortcut
  sunset_method :create, DateTime.new(2019, 1, 1)

  # Use a lambda instead of a string to inject params
  sunset_method :destroy, DateTime.new(2019, 1, 1), link: -> { v3_company_url(params['id']) }
end
```

These deprecations are logged to the `Rails.logger`, and output with `ActiveSupport::Deprecation`. You can [configure `ActiveSupport::Deprecation`][active-support-deprecation] to warn in a few different ways, or pass in any object that acts a bit like a Rack logger, Rails logger, or anything with a `warn` method that takes a string.

[active-support-deprecation]: http://api.rubyonrails.org/classes/ActiveSupport/Deprecation/Behavior.html

## Handling Those Dates

Literring your controllers with all those dates certainly doesn't seem ideal, it's basically magic numbers.

One approach would be to make a `config/initializer/deprecations.rb` with some "milestones" like this:

``` ruby
# config/initializer/deprecations.rb

SUNSET_MILESTONES = {
  drain_the_swamp: DateTime.new(2018, 2, 1),
  v2_needs_to_go: DateTime.new(2018, 4, 1),
}
```

``` ruby
# app/controllers/foo_controller.rb

sunset SUNSET_MILESTONES[:drain_the_swamp], link: 'http://example.com/blog/get-them-foos-outta-here'
```

Call em what you want, but something like this should keep things on track.

## Requirements

- **Ruby:** v2.2 - v2.4
- **Rails:** v4.2 - v5.2

## Testing

To run tests and modify locally, you'll want to `bundle install` in this directory.

``` shell
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
