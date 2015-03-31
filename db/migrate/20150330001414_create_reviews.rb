class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :business, index: true
      t.references :yelper, index: true
      t.text :review_content
      t.string :rating
      t.datetime :review_date

      t.timestamps
    end
  end
end
