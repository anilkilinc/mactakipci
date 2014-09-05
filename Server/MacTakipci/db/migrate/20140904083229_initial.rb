class Initial < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :league_id
      t.integer :week_id
      t.integer :home_id
      t.integer :away_id
      t.date :date
      t.string :score
    end

    create_table :teams do |t|
      t.string :name
      t.string :short_name
    end

    create_table :leagues do |t|
      t.string :name
      t.integer :team_count
    end

    create_join_table :teams, :leagues do |t|
      t.integer :played
      t.integer :won
      t.integer :drawn
      t.integer :lost
      t.integer :goals_for
      t.integer :goals_against
      t.integer :goals_difference
      t.integer :points
    end
  end
end
