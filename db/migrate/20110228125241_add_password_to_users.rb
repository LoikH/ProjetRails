class AddPasswordToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :secure_password, :string
  end

  def self.down
    remove_column :users, :secure_password
  end
end
