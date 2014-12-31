# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods-chillax-swift.rb'

Gem::Specification.new do |spec|
  spec.name          = "cocoapods-chillax-swift"
  spec.version       = CocoaPodsChillaxSwift::VERSION
  spec.authors       = ["Ash Furrow"]
  spec.email         = ["ash@ashfurrow.com"]
  spec.description   = %q{A CocoaPods plugin to disable compiler optimizations on certain pods.}
  spec.summary       = %q{Given an opt-in whitelist of pod names, this plugin disbles compiler optimization on those pods' targets. This is useful while the Swift compiler is still segfaulting on certain libraries when optimizations are enabled, which they are by default.}
  spec.homepage      = "https://github.com/ashfurrow/cocoapods-chillax-swift"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 10.3"
end
