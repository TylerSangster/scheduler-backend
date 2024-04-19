class AddRoleNullToUser < ActiveRecord::Migration[7.1]
  def change

    change_column :users, :role, :string, null: true
  end
end
