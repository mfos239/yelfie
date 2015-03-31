class Business < ActiveRecord::Base

  def get_url
    "http://www.yelp.com#{self.yelp_url}"
  end

end
