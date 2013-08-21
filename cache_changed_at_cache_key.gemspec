$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cache_changed_at_cache_key/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cache_changed_at_cache_key"
  s.version     = CacheChangedAtCacheKey::VERSION
  s.authors     = ["Equivalent"]
  s.email       = ["equivalent@eq8.eu"]
  s.homepage    = "http://eq8.eu"
  s.summary     = "Will use cache_changed_at column to track when was record touched"
  s.description = "Will use cache_changed_at column to track when was record touched"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.14.rc2"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'

  s.add_development_dependency "sqlite3"

  s.test_files = Dir["spec/**/*"]
end
