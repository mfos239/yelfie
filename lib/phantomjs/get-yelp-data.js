var fs = require('fs');

var system = require('system');
var args = system.args;

var page = new WebPage();

//chrome user agent
page.settings.userAgent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36';

var stepIndex = 1;
var resultsPage = 1;

var ss = 1;

//category_filter=restaurants&
var url = 'http://www.yelp.com/user_details_reviews_self?userid=' + args[1] + '&review_sort=rating';

// Callback is executed each time a page is loaded...
page.onLoadFinished = function (status) {
  if (status === 'success') {

    // Inject jQuery for scraping (you need to save jquery-1.6.1.min.js in the same folder as this file)
    page.injectJs('functions.js');

    // Our "event loop"
    if(!phantom.nextStep){
      initialize();
    } else {
      phantom.nextStep();
    }

  }
};

// Step 1
function initialize() {

  // Phantom state doesn't change between page reloads
  // We use the state to store the search result handler, ie. the next step
  stepIndex++;
  phantom.nextStep = getReviews;

  json_data = {
      name: "",
      photo_url: "",
      reviews: []
  };
    
  getUserInfo();
  getReviews();
}

function getUserInfo() {

    json_data.name = page.evaluate(function() {
        return $.trim($("div.user-header h1").html().replace("'s Profile", ""));
    });
    json_data.photo_url = page.evaluate(function() {
        return $.trim($("div#user-main-photo img").attr("src"));
    });
}

function getReviews() {

  var result = page.evaluate(function() {
	  
	  var reviews = $("div.review");
	  var csv = "";

      var range_of_total = $.trim($($(".range-of-total")[0]).text());
      var parts = range_of_total.split(" ");
      var offset = $.trim(parts[0])*1;

      var json_reviews = [];

	  reviews.each(function(index, review) {

          var o = {};

          //name
          var biz_name = $(review).find("a.biz-name");
          o.biz_name = $.trim(biz_name.text());
          o.yelp_url = $.trim(biz_name.attr("href"));

          //rating
          var star_img_title = $(review).find("i.star-img").attr("title");
          var rating = star_img_title.substring(0,2);

          o.rating = rating;

          //address
          var address = $(review).find("address").html();
          var address_parts = address.split("<br>");
          var city_state_zip = address_parts[address_parts.length - 1];
          var parsed_city_state_zip = parseCityStateZip(city_state_zip);

          o.city = $.trim(parsed_city_state_zip.city);
          o.state = $.trim(parsed_city_state_zip.state);

          //date is in a span tag called rating-qualifier
          var rating_qualifier = $(review).find("span.rating-qualifier").html();
          var rating_qualifier_parts = rating_qualifier.split("<small");
          o.date = $.trim(rating_qualifier_parts[0]);

          //full_address
          o.full_address = $.trim($(review).find("address").html().replace(/<br>/g, ", "));

          //content
          o.review_content = $.trim($(review).find("div.review-content").find("div.review-content").find("p").html());

          //photos
          var photos = $(review).find("div.review-content div.photo-box img");
          o.photos = [];
          photos.each(function(index, photo) {
              o.photos.push({
                  photo_url: photo.src,
                  caption: photo.alt
              })
          });

          json_reviews.push(o);

	  });

	  return json_reviews;
  });

  json_data.reviews.push.apply(json_data.reviews,result);

  //go to next page of results
  //determine which page we're on
  found_link = page.evaluate(function() {
      var go_to_page = $(".go-to-page");
      var current_page = $.trim($(go_to_page.find("strong")[0]).text())*1;
      var next_page = current_page + 1;

      page_link = $("#pager_page_" + next_page);

      //Clicking page link
      if(page_link.length > 0 && next_page < 10) {
          simulateClick(page_link[0]);
          return 1;
      }
      else {
          return 0;
      }
  });

  if(!found_link) {
      finish();
  }

}

function finish() {
    console.log(JSON.stringify(json_data));
    phantom.exit();
}

page.open(url);