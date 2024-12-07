class Updateadmins < ActiveRecord::Migration[7.1]
  def change
    def up
      # Set is_admin to false for any users that don't have it set
      User.where(is_admin: nil).update_all(is_admin: false)
  
      # Optionally, set is_admin to true for certain users (e.g., admin users)
      User.where(id: [1, 2, 4]).update_all(is_admin: true) # Adjust this list as needed
    end
  
    def down
      # Rollback to initial state (optional, but can be useful)
      User.update_all(is_admin: nil)
    end
  end
end
