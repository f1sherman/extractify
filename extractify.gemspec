# -*- encoding: utf-8 -*-
require File.expand_path('../lib/extractify/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Brian John"]
  gem.email         = ["brian@brianjohn.com"]
  gem.description   = %q{extract grouped data from XML or HTML}
  gem.summary       = %q{extract grouped data from XML or HTML}
  gem.homepage      = "https://github.com/f1sherman/extractify"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "extractify"
  gem.require_paths = ["lib"]
  gem.version       = Extractify::VERSION

  gem.add_dependency 'nokogiri'

  gem.add_development_dependency 'rspec'
end
