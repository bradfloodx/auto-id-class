# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [0.7.0] - 2018-03-29

### Fixed

* prevent popup windows from activating the function on the code in the background when dot or hash is typed - [PR #13](https://github.com/bradleyflood/auto-id-class/pull/12)

## [0.6.0] - 2018-03-28

### Added

* support multiple cursors - [PR #12](https://github.com/bradleyflood/auto-id-class/pull/12)

## [0.5.0] - 2018-03-24

### Fixed

* https://github.com/bradleyflood/auto-id-class/issues/1 - "Disable in closing tags"

### Added

* disable in doctype tags, that is, within any tag that starts with `<!` (does not affect HTML comments)
* this plugin will add classes or id's within HTML comments

## [0.4.0] - 2018-03-24

### Fixed

* https://github.com/bradleyflood/auto-id-class/issues/5 - "Disable in erb tags #5" - [PR #10](https://github.com/bradleyflood/auto-id-class/pull/10)
* https://github.com/bradleyflood/auto-id-class/issues/8 - "php concatenation inside an html tag" - [PR #10](https://github.com/bradleyflood/auto-id-class/pull/10)
* https://github.com/bradleyflood/auto-id-class/issues/9 - "Disable within attribute value quotes" - [PR #10](https://github.com/bradleyflood/auto-id-class/pull/10)

### Added

* set up [Prettier](https://prettier.io/) - [PR #10](https://github.com/bradleyflood/auto-id-class/pull/10)
* updated CHANGELOG to follow keepachangelog.com format - [PR #10](https://github.com/bradleyflood/auto-id-class/pull/10)
* added diff links to CHANGELOG - [PR #10](https://github.com/bradleyflood/auto-id-class/pull/10)
* badges to README - [PR #10](https://github.com/bradleyflood/auto-id-class/pull/10)
* [husky](https://www.npmjs.com/package/husky) to enable [Prettier](https://prettier.io/) to run during as a precommit hook

## [0.3.1] - 2017-07-11

### Added

* tidied up code
* converted to vanilla ES6
* converted to tab-based indentation

## [0.3.0] - 2017-07-11

### Added

* support for JSX HTML blocks - [PR #7](https://github.com/bradleyflood/auto-id-class/pull/7)

## [0.2.6] - 2015-09-17

### Fixed

* bug #2 - "Uncaught TypeError: Cannot read property 'cursors' of undefined"

## [0.2.5] - 2015-08-13

### Fixed

* cursor bug when entering content in file name/path dialog

## [0.2.4] - 2015-08-12

### Removed

* quotes checking logic (handled by cursor scope instead)

## [0.2.3] - 2015-08-12

### Added

* More instructions in readme

## [0.2.2] - 2015-08-12

### Added

* Basic instructions in readme

## [0.2.1] - 2015-08-12

### Added

* Add screenshot to readme

## [0.2.0] - 2015-08-12

### Added

* First release

## 0.1.0 - 2015-08-07

### Added

* It works!

[0.7.0]: https://github.com/bradleyflood/auto-id-class/compare/v0.6.0...v0.7.0
[0.6.0]: https://github.com/bradleyflood/auto-id-class/compare/v0.5.0...v0.6.0
[0.5.0]: https://github.com/bradleyflood/auto-id-class/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/bradleyflood/auto-id-class/compare/v0.3.1...v0.4.0
[0.3.1]: https://github.com/bradleyflood/auto-id-class/compare/v0.3.0...v0.3.1
[0.3.0]: https://github.com/bradleyflood/auto-id-class/compare/v0.2.6...v0.3.0
[0.2.6]: https://github.com/bradleyflood/auto-id-class/compare/v0.2.5...v0.2.6
[0.2.5]: https://github.com/bradleyflood/auto-id-class/compare/v0.2.4...v0.2.5
[0.2.4]: https://github.com/bradleyflood/auto-id-class/compare/v0.2.3...v0.2.4
[0.2.3]: https://github.com/bradleyflood/auto-id-class/compare/v0.2.2...v0.2.3
[0.2.2]: https://github.com/bradleyflood/auto-id-class/compare/v0.2.1...v0.2.2
[0.2.1]: https://github.com/bradleyflood/auto-id-class/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/bradleyflood/auto-id-class/compare/v0.1.0...v0.2.0
