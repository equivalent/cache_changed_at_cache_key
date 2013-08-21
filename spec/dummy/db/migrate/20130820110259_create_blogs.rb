class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.datetime :cache_changed_at
      t.timestamps
    end
  end
end
