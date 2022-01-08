class CreateThoughts < ActiveRecord::Migration[7.0]
  def change
    create_table :thoughts do |t|
      t.string :related_to
      t.string :title
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
