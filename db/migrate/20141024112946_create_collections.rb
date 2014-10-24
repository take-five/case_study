class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.belongs_to :user
      t.string :name

      t.timestamps

      t.index [:user_id, :name]
    end
  end
end
