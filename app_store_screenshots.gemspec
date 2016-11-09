# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'app_store_screenshots/version'

Gem::Specification.new do |spec|
  spec.name          = AppStoreScreenshots::APP
  spec.version       = AppStoreScreenshots::VERSION
  spec.authors       = ['Daniel Khamsing']
  spec.email         = ['dkhamsing8@gmail.com']

  spec.summary       = AppStoreScreenshots::SUMMARY
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/dkhamsing/app_store_screenshots'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
