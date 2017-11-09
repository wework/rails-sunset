# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [v0.1.0] - 2017-10-09
### Changed
- link lambda/proc/whatever is now called in the scope of the instance, so any instance methods, params, etc will be available. E.g: `link: -> { foo_url(params['id']) }`

## [v0.1.0-alpha1] - 2017-10-07
### Added
- Initial version. Pretty basic, but adds a `sunset` method to mark things as deprecated
