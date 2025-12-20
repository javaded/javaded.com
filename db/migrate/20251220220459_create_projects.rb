class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :slug
      t.text :description
      t.string :status
      t.boolean :featured

      t.timestamps
    end
  end
end
