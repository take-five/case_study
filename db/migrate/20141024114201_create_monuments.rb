class CreateMonuments < ActiveRecord::Migration
  def change
    create_table :monuments do |t|
      t.belongs_to :collection, null: false, index: true
      t.belongs_to :category, null: false, index: true

      t.string :name, null: false
      t.text :description

      t.integer :pictures_count, default: 0

      t.timestamps
    end
  end
end
