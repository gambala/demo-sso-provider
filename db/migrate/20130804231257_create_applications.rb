class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :name
      t.string :uid
      t.string :secret
      t.string :redirect_uri
      t.integer :account_id

      t.timestamps
    end
  end
end
