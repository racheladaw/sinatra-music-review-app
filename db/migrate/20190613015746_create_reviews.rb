class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :content
      t.integer :rating
      t.integer :user_id
      t.integer :album_id
    end 
  end
end
