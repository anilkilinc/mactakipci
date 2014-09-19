class Team < ActiveRecord::Base
  has_many :seasons
  has_many :leagues, through: :seasons
  has_many :subscriptions
  has_many :users, through: :subscriptions
end
