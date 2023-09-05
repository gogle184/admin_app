class RemoveAuthorFromTitles < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :prefecture, :string
  end
end
