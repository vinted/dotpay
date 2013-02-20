# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dotpay/version"

Gem::Specification.new do |s|
  s.name        = "dotpay"
  s.version     = Dotpay::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Laurynas Butkus", "Mindaugas Mozuras", "Tomas Varaneckas"]
  s.email       = ["laurynas.butkus@gmail.com", "mindaugas.mozuras@gmail.com", "tomas.varaneckas@gmail.com"]

  s.homepage    = "https://github.com/friendlyfashion/dotpay"
  s.summary     = "dotpay gem"
  s.description = "Online payments using dotpay.pl"

  s.files = Dir["{lib}/**/*"] + ["Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency 'activesupport', '>= 3.0.0'
end
