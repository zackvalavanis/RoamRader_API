class Remove < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :is_admin
  end
end
