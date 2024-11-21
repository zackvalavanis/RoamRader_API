class CreateCities < ActiveRecord::Migration[7.1]
  def change
    create_table :cities do |t|
      t.integer :user_id
      t.string :name
      t.string :location

      t.timestamps
    end
  end
end
