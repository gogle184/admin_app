class AddNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string, null: false, default: ""
    add_column :users, :old, :integer, null: false, default: 0
    add_column :users, :prefecture, :string, null: false, default: ""
  end
end
