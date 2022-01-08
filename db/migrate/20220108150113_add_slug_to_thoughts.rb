class AddSlugToThoughts < ActiveRecord::Migration[7.0]
  def change
    add_column :thoughts, :slug, :string
    add_index :thoughts, :slug, unique: true
  end
end
