class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :full_address
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :yelp_id
      t.string :yelp_url
      t.string :website_url

      t.timestamps
    end
  end
end
