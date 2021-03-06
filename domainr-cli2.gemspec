# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'domainr/cli2/version'

Gem::Specification.new do |spec|
  spec.name          = "domainr-cli2"
  spec.version       = Domainr::CLI2::VERSION
  spec.authors       = ["Chris Bielinski"]
  spec.email         = ["chris@shadow.io"]
  spec.summary       = 'Search for domain names from the command line.'
  spec.description   = 'Provides a handy command line interface to the domainr gem.'
  spec.homepage      = 'https://github.com/chrisb/domainr-cli2'
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency 'thor', '~> 0.19'
  spec.add_dependency 'colored', '~> 1'
  spec.add_dependency 'domainr', '~> 1'
  spec.add_dependency 'terminal-table', '~> 1'
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
