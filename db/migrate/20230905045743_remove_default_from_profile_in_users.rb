class RemoveDefaultFromProfileInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :profile, :json
  end
end
