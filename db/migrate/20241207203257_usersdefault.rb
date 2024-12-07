class Usersdefault < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :is_admin, false
  end
end
