class AddGeometryAndPhotoUrlToCities < ActiveRecord::Migration[7.1]
  def change
    add_column :cities, :geometry, :jsonb
    add_column :cities, :photo_url, :string
  end
end
