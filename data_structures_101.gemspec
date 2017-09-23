# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'data_structures_101/version'

Gem::Specification.new do |spec|
  spec.name          = "data_structures_101"
  spec.version       = DataStructures101::VERSION
  spec.authors       = ["renehernandez"]
  spec.email         = ["renehr9102@gmail.com"]

  spec.summary       = %q{DataStructures101 is a simple gem that groups several implementations of common data structures usually taught in Computer Science courses.}
  spec.homepage      = "https://github.com/renehernandez/data_structures_101"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features|doc|tasks)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "reek", "~> 4.7"
  spec.add_development_dependency "rubocop", "~> 0.49"
  spec.add_development_dependency "yard", "~> 0.9"
  spec.add_development_dependency "redcarpet", "~> 3.4"
  spec.add_development_dependency "github-markup", "~> 1.6"
  spec.add_development_dependency "simplecov"
  unless ENV['CI']
    spec.add_development_dependency "benchmark-ips", "~> 2.7"
    spec.add_development_dependency "gruff", "~> 0.7"
  end
end
