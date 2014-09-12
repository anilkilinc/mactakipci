class CreateUsers < ActiveRecord::Migration
  def change
    rename_table :teams_users, :subscriptions
    add_column(:subscriptions, :created_at, :datetime)
    add_column(:subscriptions, :updated_at, :datetime)
  end
end
