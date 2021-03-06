# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chopsticks/version'

Gem::Specification.new do |gem|
  gem.name          = "chopsticks"
  gem.version       = Chopsticks::VERSION
  gem.authors       = ["Seiji Toyama"]
  gem.email         = ["seijit@me.com"]
  gem.description   = %q{just Feed Reader}
  gem.summary       = %q{read feeds}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency 'thor'
end
