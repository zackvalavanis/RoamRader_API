class Updateadmin < ActiveRecord::Migration[7.1]
  def change
    change_column_null :users, :is_admin, false # Enforces non-null constraint
  end
end
