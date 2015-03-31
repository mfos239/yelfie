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

    cmd = 'phantomjs "/Users/michaelfoster/Dropbox (Docright)/Dev/Tools/phantomjs/scripts/get-yelp-data.js" ' + self.yelp_user_id
    json_str = %x( #{cmd} )

    json_str2 = <<-json
{"name":"Jessica T.","photo_url":"http://s3-media2.fl.yelpassets.com/photo/xtLi6T3OdVaF9PwHA58SUA/ms.jpg","reviews":[{"biz_name":"Hakata Tonton","city":"New York","date":"1/13/2015","full_address":"61 Grove St, New York, NY 10014","photos":[],"rating":"5.","review_content":"Easily the absolute best dining experience I have had in the city! The food was exquisite, filled with a variety of flavor all in one bite! The service was beyond spectacular and the staff was not only sweet and knowledgable on the menu items, they went out of their way to accommodate!!! Definitely a must try...I guarantee you will have the same superb experience!:)","state":"NY","yelp_url":"/biz/hakata-tonton-new-york-3"},{"biz_name":"85°C Bakery Cafe","city":"San Diego","date":"11/22/2014","full_address":"5575 Balboa Ave, San Diego, CA 92111","photos":[{"caption":"85°C Bakery Cafe - San Diego, CA, United States","photo_url":"http://s3-media2.fl.yelpassets.com/bphoto/MJ-fNYZdhiE2jTmrUmdn8g/348s.jpg"}],"rating":"5.","review_content":"Wow, the hype was real and more than I had ever anticipated! From the moment you reach the front door until you reach the cashier, the customer service is absolutely spectacular! Everyone who worked there was so friendly and helpful! Even with a long line, the process was so very efficient and timely. All of the pastries were absolutely delicious...couldn't help but to take a bite of every one of them when I got home! Great first time experience and I will definitely be back sometime in the near, near future!","state":"CA","yelp_url":"/biz/85-c-bakery-cafe-san-diego-3"},{"biz_name":"Punjabi Tandoor","city":"San Diego","date":"3/12/2015","full_address":"9235 Activity Rd, San Diego, CA 92126","photos":[{"caption":"Punjabi Tandoor - The Lamb curry and the Chicken Tikki Marsala curry...Ahmazinggggg - San Diego, CA, United States","photo_url":"http://s3-media1.fl.yelpassets.com/bphoto/jkAQKya8htQcUXms5VFg4A/348s.jpg"}],"rating":"5.","review_content":"Easily the best Indian food I have ever had in my life...definitely a hidden gem to say the least! The food tasted absolutely amazing, filled with a variety of flavor all in one bite (the chicken Tikki Marsala is a must try!). Not only did the food fulfill every taste bud on my tongue...the place has &nbsp;unsurpassed customer service! The sweet/smiley lady at the cashier saw that I was having trouble deciding on which item to choose so she literally ordered for me their most popular items and gave me a free dessert! Definitely coming back very, very soon!","state":"CA","yelp_url":"/biz/punjabi-tandoor-san-diego"},{"biz_name":"Boto Sushi","city":"San Diego","date":"1/3/2015","full_address":"11835 Carmel Mountain Rd, San Diego, CA 92128","photos":[{"caption":"Boto Sushi - San Diego, CA, United States","photo_url":"http://s3-media1.fl.yelpassets.com/bphoto/LLRBl7MmnpYV43eEipFJ-Q/348s.jpg"},{"caption":"Boto Sushi - San Diego, CA, United States","photo_url":"http://s3-media3.fl.yelpassets.com/bphoto/Jw-K_pz3I-tuH2_E3pJX4Q/168s.jpg"},{"caption":"Boto Sushi - San Diego, CA, United States","photo_url":"http://s3-media2.fl.yelpassets.com/bphoto/RPdOjfwsX3Cf5Z2es8FYgQ/168s.jpg"}],"rating":"5.","review_content":"I can't say enough good things about this new establishment...the sushi is perfectly filled with various flavors that just burst in your mouth with every bite! Sushi Chef Albert is the bestttt ...not only is he absolutely hilarious and such a nice guy, but he knows exactly what he's doing when it comes to being a sushi chef! He makes the experience memorable with every visit and definitely keeps us coming back for more!!!","state":"CA","yelp_url":"/biz/boto-sushi-san-diego-4"},{"biz_name":"Up2you Cafe","city":"San Diego","date":"3/12/2015","full_address":"7510 Mesa College Dr, San Diego, CA 92111","photos":[{"caption":"Up2you Cafe - Honey Toast with a scoop of vanilla ice-cream and strawberries! - San Diego, CA, United States","photo_url":"http://s3-media2.fl.yelpassets.com/bphoto/54UPwuC8ZeUoMm_da-YdzQ/168s.jpg"},{"caption":"Up2you Cafe - Cool menu set up! - San Diego, CA, United States","photo_url":"http://s3-media1.fl.yelpassets.com/bphoto/6BxtQgHSQ_rhCnMhreLfyA/168s.jpg"}],"rating":"5.","review_content":"Love this place!!!!! Love coming here to catch up with friends or just a chill evening catching up on work! I always get their almond milk tea with their absolutely mouth watering honey boba! You can NEVER go wrong with the honey toast decked with your choice of toppings! Not only do they have an extraordinary and unique menu, their staff is awesome! They are friendly and always know which menu items to recommend!!! Check it out for yourself, you will not be disappointed!","state":"CA","yelp_url":"/biz/up2you-cafe-san-diego-3"},{"biz_name":"Soda & Swine","city":"San Diego","date":"10/17/2014","full_address":"2943 Adams Ave, San Diego, CA 92116","photos":[],"rating":"5.","review_content":"Love this place...not only is the food absolutely fantastic and on point every time, it's Rustic, old-fashioned, yet hip feel makes it unique! The swine a la carte (meatballs), roasted Brussels sprouts with bacon, and the Mac &amp; cheese are to die for!","state":"CA","yelp_url":"/biz/soda-and-swine-san-diego"},{"biz_name":"Sushi Diner","city":"San Diego","date":"10/30/2014","full_address":"7530 Mesa College Dr, San Diego, CA 92111","photos":[{"caption":"Sushi Diner - Smokin' Jamaican, 96 Degree & the Bruce Lee - San Diego, CA, United States","photo_url":"http://s3-media4.fl.yelpassets.com/bphoto/I4y5AhGg5Gal2QsHg__zng/168s.jpg"},{"caption":"Sushi Diner - Poke Salad with Salmon - San Diego, CA, United States","photo_url":"http://s3-media4.fl.yelpassets.com/bphoto/Br8M-6tMM-Tt41kfq2zpDw/168s.jpg"}],"rating":"5.","review_content":"Been meaning to check out this place for a while now and finally had the chance to...all I gotta say is the sushi is delicious, they have unsurpassed customer service and their happy hour is awesome! The dressing on the poke salad was a little strong (which overtook the salmon) but overall great experience!!!","state":"CA","yelp_url":"/biz/sushi-diner-san-diego"},{"biz_name":"Siam Nara","city":"San Diego","date":"10/17/2014","full_address":"8993 Mira Mesa Blvd, San Diego, CA 92126","photos":[],"rating":"4.","review_content":"This is the place to go if you're ever craving Thai food! The decor is absolutely stunning. If you go, you've got to try the Panang Curry, Pad Thai, and the Basil Eggplant...delicious!!!","state":"CA","yelp_url":"/biz/siam-nara-san-diego"},{"biz_name":"Snooze","city":"San Diego","date":"10/28/2014","full_address":"3435 Del Mar Heights Rd, San Diego, CA 92130","photos":[],"rating":"4.","review_content":"Great breakfast spot &amp; the pineapple upside down pancakes are a MUST (unless you're allergic, that is;) )Amazing service and friendly staff. So worth the wait!","state":"CA","yelp_url":"/biz/snooze-san-diego-8"},{"biz_name":"Bud’s Louisiana Cafe","city":"San Diego","date":"10/18/2014","full_address":"4320 Viewridge Ave, San Diego, CA 92123","photos":[],"rating":"4.","review_content":"The food is enriched with so many different flavors in one bite! Absolutely mouthwatering just thinking about it! I can't get enough of the Louisiana Chicken and the the Jalapeño cornbread! The service is a tad bit slow but the staff never fail to impress when it comes to displaying knowledge on the various menu items!:)","state":"CA","yelp_url":"/biz/buds-louisiana-cafe-san-diego"}]}
    json

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
