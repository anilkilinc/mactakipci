class Gcm < ActiveRecord::Migration
  def change
    create_table :users do |item|
      item.string :gcm_regid
      item.timestamps
    end
    create_join_table :users, :teams
    add_column :matches, :notified, :boolean
  end
end
