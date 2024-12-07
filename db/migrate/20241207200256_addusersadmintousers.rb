class Addusersadmintousers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :is_admin, :boolean, default: true, null: false
  end
end
