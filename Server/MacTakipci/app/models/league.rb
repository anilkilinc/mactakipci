class League < ActiveRecord::Base
  has_many :seasons
  has_many :teams, through: :seasons
end
