class CreatePlaces < ActiveRecord::Migration[7.1]
  def change
    create_table :places do |t|
      t.integer :user_id
      t.integer :home_id
      t.text :comments

      t.timestamps
    end
  end
end
