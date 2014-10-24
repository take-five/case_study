class CreateMonuments < ActiveRecord::Migration
  def change
    create_table :monuments do |t|
      t.belongs_to :collection, null: false, index: true
      t.belongs_to :category, null: false, index: true

      t.string :picture, null: false
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
  end
end
