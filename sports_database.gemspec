# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sports_database/version'

Gem::Specification.new do |spec|
  spec.name          = "sports_database"
  spec.version       = SportsDatabase::VERSION
  spec.authors       = ["dtkocher"]
  spec.email         = ["dtkocher@gmail.com"]

  spec.summary       = %q{A ruby client to help with interacting to http://www.sportsdatabase.com/api.}
  spec.description   = %q{A ruby client to help with interacting to http://www.sportsdatabase.com/api.}
  spec.homepage      = "https://github.com/dtkocher/sports_database"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "byebug", "~> 3.5"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "simplecov", "~> 0.9"
  spec.add_dependency "faraday", "~> 0.9.1"
  spec.add_dependency "faraday_middleware", "~> 0.9.1"
  spec.add_dependency "typhoeus", "~> 0.7.1"
end

