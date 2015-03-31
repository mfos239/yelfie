class Photo < ActiveRecord::Base
  belongs_to :yelper
  belongs_to :review
end
