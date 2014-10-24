class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :username,           null: false
      t.string :email,              null: false
      t.string :encrypted_password, null: false

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.index :email, :unique => true
      t.index :reset_password_token, :unique => true
      t.index :username, :unique => true

      t.timestamps
    end
  end
end
