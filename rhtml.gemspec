# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rhtml/version'

Gem::Specification.new do |spec|
  spec.name          = "rhtml"
  spec.version       = Rhtml::VERSION
  spec.authors       = ["wenjun.yan"]
  spec.email         = ["mylastnameisyan@gmail.com"]
  spec.description   = %q{a little dsl that let you write html in ruby , pure ruby.}
  spec.summary       = %q{writing html in ruby not inserting them in a template...}
  spec.homepage      = "https://github.com/v2e4lisp/rhtml"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
