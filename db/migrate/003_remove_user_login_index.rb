class RemoveUserLoginIndex < ActiveRecord::Migration
  def self.up
    remove_index "users", :name => "login"
  end
  
  def self.down
  end
end
