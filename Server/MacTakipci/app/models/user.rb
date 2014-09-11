class User < ActiveRecord::Base
  has_and_belongs_to_many :teams

  def self.fonksiyon
    where :price=>300
  end
end
