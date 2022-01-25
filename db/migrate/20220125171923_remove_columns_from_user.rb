class RemoveColumnsFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :name
    remove_column :users, :strategy
    remove_column :users, :uid
  end
end
