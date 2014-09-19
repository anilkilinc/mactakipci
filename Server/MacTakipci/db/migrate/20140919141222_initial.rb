class Initial < ActiveRecord::Migration
  def change
    create_table :leagues, force: true do |t|
      t.string :name
      t.timestamps
    end

    create_table :teams, force: true do |t|
      t.string :name
      t.string :short_name
    end

    create_table :seasons, force: true do |t|
      t.belongs_to :league
      t.belongs_to :team
      t.integer :played
      t.integer :won
      t.integer :drawn
      t.integer :lost
      t.integer :goals_for
      t.integer :goals_against
      t.integer :goals_difference
      t.integer :points
    end

    create_table :matches, force: true do |t|
      t.integer :home_id
      t.integer :away_id
      t.integer :home_score
      t.integer :away_score
      t.date :date
      t.boolean :notified
    end

    create_table :users, force: true do |t|
      t.string :gcm_regid
      t.timestamps
    end

    create_table :subscriptions, force: true do |t|
      t.belongs_to :user
      t.belongs_to :team
      t.timestamps
    end
  end
end
