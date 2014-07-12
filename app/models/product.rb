class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :reviews
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }

  def average_rating
  	rev = self.reviews.all
  	rating = 0.0
  	rev.each do |r|
  		rating = rating + r.rating
  	end

  	rating / rev.count
  end
end
