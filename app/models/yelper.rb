class Yelper < ActiveRecord::Base

  validates_presence_of :yelp_user_id

  attr_accessor :yelp_profile_url

  has_many :reviews

  def parse_user_id
    require 'cgi'

    if not self.yelp_profile_url.present?
      errors.add :yelp_profile_url, "Please enter a Yelp Profile URL"
    else
      begin
        uri = URI.parse(self.yelp_profile_url)
        query_params = CGI::parse(uri.query)
        self.yelp_user_id = query_params["userid"][0]
      rescue
        errors.add :yelp_profile_url, "Invalid Yelp Profile URL"
      end
    end
  end

  def run_update

    cmd = "phantomjs \"#{Rails.root.join('lib','phantomjs', "get-yelp-data.js")}\" " + self.yelp_user_id
    puts cmd
    json_str = %x( #{cmd} )

    begin
      json_data = JSON.parse json_str
    rescue
      errors.add :yelp_profile_url, "Something went wrong loading data for the provided URL. Please make sure you entered the entire Yelp Profile URL and try again."
      return false
    end

    #update yelper name and photo
    self.name = json_data["name"]
    self.photo_url = json_data["photo_url"]
    save

    #remove old reviews and photos
    reviews.destroy_all

    #add reviews
    json_data["reviews"].each do |r|

      #find/create business
      b = Business.where(name: r["biz_name"], yelp_url: r["yelp_url"]).first
      if b.nil?
        b = Business.create({name: r["biz_name"], yelp_url: r["yelp_url"], full_address: r["full_address"]})
      end

      #add reviews and photos
      review = reviews.create({business_id: b.id,
                               rating: r["rating"].to_i,
                               review_content: r["review_content"],
                               review_date: Date.strptime(r["date"], '%m/%d/%Y')
                              })
      r["photos"].each do |photo|
        review.photos.create({yelper_id: id,
                              photo_url: photo["photo_url"],
                              caption: photo["caption"]
                             })
      end
    end

    return true

  end

end
