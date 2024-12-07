class Updateuseradmin < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :is_admin, :boolean, default: false, null: false
  end
end
