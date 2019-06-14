class Review < ActiveRecord::Base
  validates :rating, :content, presence: true
  belongs_to :album
  belongs_to :user
end
