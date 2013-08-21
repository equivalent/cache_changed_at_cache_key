require "cache_changed_at_cache_key/engine"
require "cache_changed_at_cache_key/cache_changed_at_cache_key_concern"

class ActiveRecord::Base
  include CacheChangedAtCacheKeyConcern
end
