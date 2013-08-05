class AddAcceptedToGrants < ActiveRecord::Migration
  def change
    add_column :grants, :accepted, :boolean
  end
end
