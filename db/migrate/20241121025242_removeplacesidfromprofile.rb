class Removeplacesidfromprofile < ActiveRecord::Migration[7.1]
  def change
    remove_column :profiles, :myplaces_id, :string
  end
end
