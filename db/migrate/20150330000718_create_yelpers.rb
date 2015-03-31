class CreateYelpers < ActiveRecord::Migration
  def change
    create_table :yelpers do |t|
      t.string :name
      t.string :yelp_user_id
      t.string :photo_url

      t.timestamps
    end
  end
end
