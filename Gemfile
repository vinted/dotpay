source "http://rubygems.org"

gem 'rake'

gemspec

testing = File.expand_path("Gemfile.testing")
if File.exists?(testing)
  eval File.read(testing)
end

personal = File.expand_path("Gemfile.personal")
if File.exists?(personal)
  eval File.read(personal)
end
