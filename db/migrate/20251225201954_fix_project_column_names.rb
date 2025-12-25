class FixProjectColumnNames < ActiveRecord::Migration[8.0]
  def change
    rename_column :projects , :features, :featured
  end
end
