class AddCommentedByToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :commented_by, :string
  end
end
