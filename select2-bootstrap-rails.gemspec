# -*- encoding: utf-8 -*-
require File.expand_path("../lib/select2-bootstrap-rails/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "select2-bootstrap-rails"
  s.version     = Select2Bootstrap::Rails::VERSION
  s.authors     = ["Muneza Karl"]
  s.email       = ["kazozaagiro@gmail.com"]
  s.homepage    = "https://github.com/karl257/select2-bootstrap-rails"
  s.summary     = %q{Integrate Select2 and Select2 Bootstrap 5 Theme  with the Rails asset pipeline.}
  s.description = %q{Select2, a jQuery-based substitute for select boxes, offers features such as search functionality, support for remote data sets, and infinite result scrolling. This gem offers search, remote data loading, and infinite scrolling, all wrapped in a beautiful Bootstrap 5 theme. Integrating them with your Rails app has never been easier.}
  s.license     = 'MIT'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "thor", "~> 1"
  s.add_development_dependency "bundler", ">= 2"
  s.add_development_dependency "rails", ">= 3.0"
  s.add_development_dependency "httpclient", "~> 2.2"
end

