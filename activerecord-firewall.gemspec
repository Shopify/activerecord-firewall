$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "activerecord/firewall/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "activerecord-firewall"
  s.version     = Activerecord::Firewall::VERSION
  s.authors     = ["Shopify"]
  s.email       = ["jack.mccracken@shopify.com"]
  s.homepage    = "https://shopify.github.io"
  s.summary     = "'Firewall' access to models not associated with the current request and their descendents"
  s.description = "'Firewall' access to models not associated with the current request and their descendents"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.0"

  s.add_development_dependency "sqlite3"
end
