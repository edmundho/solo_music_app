class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.integer :band_id, null: false
      t.string :title, null: false
      t.string :year, null: false
      t.boolean :live, default: false
      t.boolean :studio, default: true

      t.timestamps
    end

    add_index :albums, :band_id, unique: true
  end
end
