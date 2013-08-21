module CacheChangedAtCacheKeyConcern
  extend ActiveSupport::Concern

  included do
    before_save :set_cache_changed_at
  end

  def set_cache_changed_at
    self.cache_changed_at = current_time_from_proper_timezone  if respond_to?(:cache_changed_at)
  end

  def touch_cache
    if respond_to?(:cache_changed_at)
      update_column :cache_changed_at, current_time_from_proper_timezone
    else
      touch
    end
  end

  def touch(*args)
    super(:cache_changed_at) if respond_to?(:cache_changed_at)
    super(*args)
  end
end
