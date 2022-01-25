class AddTitleToBulletins < ActiveRecord::Migration[6.1]
  def change
    remove_column :bulletins, :name, :string
    add_column :bulletins, :title, :string, null: false
  end
end
