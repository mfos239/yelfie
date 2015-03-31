class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :yelper, index: true
      t.references :review, index: true
      t.string :photo_url
      t.string :caption

      t.timestamps
    end
  end
end
