class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.belongs_to :monument
      t.string :image, null: false
      t.integer :width, null: false
      t.integer :height, null: false
      t.string :name
      t.text :description
      t.date :taken_at

      t.timestamps

      t.index [:monument_id, :taken_at]
    end
  end
end
