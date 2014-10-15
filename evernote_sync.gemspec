# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'evernote_sync/version'

Gem::Specification.new do |spec|
  spec.name          = "evernote_sync"
  spec.version       = EvernoteSync::VERSION
  spec.authors       = ["oozzal"]
  spec.email         = ["theoozzal@gmail.com"]
  spec.summary       = %q{A command-line tool to sync notes, scripts and urls across machines.}
  spec.description   = %q{Additionally, the syncables can be marked/un-marked as synced.}
  spec.homepage      = "https://github.com/oozzal/evernote_sync"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
