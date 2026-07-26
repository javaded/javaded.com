class TightenPostsAndProjects < ActiveRecord::Migration[8.0]
  def change
    change_table :posts, bulk: true do |t|
      t.datetime :published_at
      t.integer :reading_time, default: 1, null: false
    end

    change_table :projects, bulk: true do |t|
      t.string :url
      t.string :tagline
    end

    add_index :posts, :slug, unique: true
    add_index :projects, :slug, unique: true
    add_index :posts, :published_at
    add_index :projects, :featured
  end
end
