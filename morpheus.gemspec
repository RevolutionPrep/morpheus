# -*- encoding: utf-8 -*-
require File.expand_path('../lib/morpheus/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Ryan Moran']
  gem.email         = ['ryan.moran@revolutionprep.com']
  gem.description   = %q{RESTful API Client}
  gem.summary       = %q{RESTful API Client}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'morpheus'
  gem.require_paths = ['lib']
  gem.version       = Morpheus::VERSION

  gem.add_dependency 'yajl-ruby',     '~> 0.8.2'
  gem.add_dependency 'typhoeus',      '~> 0.2.4'
  gem.add_dependency 'activemodel',   '> 3.0.0'
  gem.add_dependency 'activesupport', '> 3.0.0'
  gem.add_dependency 'i18n',          '> 0.5.0'

  gem.add_development_dependency 'rails',               '> 3.0.0'
  gem.add_development_dependency 'sqlite3',             '~> 1.3.3'
  gem.add_development_dependency 'rspec-rails',         '~> 2.7.0'
  gem.add_development_dependency 'rcov',                '~> 0.9.11'
  gem.add_development_dependency 'autotest-standalone', '~> 4.5.8'
end
