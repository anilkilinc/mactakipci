class User < ActiveRecord::Base
  has_many :subscriptions
  has_many :teams, through: :subscriptions

  def self.fonksiyon
    where :price=>300
  end
end
