class Initial < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :league_id
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
      t.string :country
    end

    create_join_table :teams, :leagues do |t|
      t.int :played
      t.int :won
      t.int :drawn
      t.int :lost
      t.int :goals_for
      t.int :goals_against
      t.int :goals_difference
      t.int :points
    end
  end
end
