class CreateGrants < ActiveRecord::Migration
  def change
    create_table :grants do |t|
      t.string :code
      t.string :access_token
      t.string :refresh_token
      t.datetime :access_token_expires_at
      t.integer :account_id
      t.integer :application_id

      t.timestamps
    end
  end
end
