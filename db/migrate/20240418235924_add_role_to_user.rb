class AddRoleToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :string, null: false
  end
end
