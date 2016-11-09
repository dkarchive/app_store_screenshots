# app_store_screenshots

Grab screenshots from the App Store.

[![CircleCI](https://img.shields.io/circleci/project/github/dkhamsing/app_store_screenshots.svg)](https://circleci.com/gh/dkhamsing/app_store_screenshots)

## Installation

    $ git clone https://github.com/dkhamsing/app_store_screenshots.git
    $ rake install

## Usage

```shell
app_store_screenshots <app store url> [--open] [--save]
  # --open  open screenshots in browser
  # --save  save screenshots
```

```
$ app_store_screenshots https://itunes.apple.com/us/app/instagram/id389801252?mt=8
> app_store_screenshots 0.1.0
> Getting screenshots for 389801252...
> Found 5 screenshot(s):
[
  "http://a5.mzstatic.com/us/r30/Purple60/v4/4e/94/ef/4e94efe2-5ad7-bc50-1d6e-8d135f363d84/screen696x696.jpeg",
  "http://a3.mzstatic.com/us/r30/Purple60/v4/b6/fe/4e/b6fe4e9b-9cdc-4ad3-489e-f369e0f89918/screen696x696.jpeg",
  "http://a1.mzstatic.com/us/r30/Purple60/v4/ca/24/61/ca246154-134c-ccc7-7dc0-375522d25662/screen696x696.jpeg",
  "http://a2.mzstatic.com/us/r30/Purple18/v4/da/5f/fb/da5ffb51-349f-5d3b-aa23-1544b4f5d24a/screen696x696.jpeg",
  "http://a3.mzstatic.com/us/r30/Purple18/v4/51/71/e0/5171e09e-81ea-0014-17c5-73c410d20ded/screen696x696.jpeg"
]
```

This was pretty handy for [`osia`](https://github.com/dkhamsing/open-source-ios-apps/issues/431).

## Credits

- [itunes_store_bot](https://github.com/stefano-bortolotti/itunes_store_bot)

## Contact

- [github.com/dkhamsing](https://github.com/dkhamsing)
- [twitter.com/dkhamsing](https://twitter.com/dkhamsing)

## License

This project is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
