class Review < ActiveRecord::Base
  belongs_to :business
  belongs_to :yelper
  has_many :photos, :dependent => :destroy

end
