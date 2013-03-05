# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vat-calculator/version'

Gem::Specification.new do |gem|
  gem.name          = "vat-calculator"
  gem.version       = Vat::Calculator::VERSION
  gem.authors       = ["Alex Klyanchin"]
  gem.email         = ["jetblackmeerkat@gmail.com"]
  gem.description   = %q{Gem for calculating product sum with vat, product sum without vat and product sum of vat.}
  gem.summary       = %q{Calculate product sum with vat, product sum without vat and product sum of vat.}
  gem.homepage      = "https://github.com/7Pikes/vat-calculator"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency("activerecord", ">= 3.0.0")
end
