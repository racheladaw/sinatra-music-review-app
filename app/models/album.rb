class Album < ActiveRecord::Base
  validates :name, :artist, :release_date, presence: true
  validates :name, uniqueness: true
  has_many :reviews
  has_many :users, through: :reviews

  def slug
   self.name.downcase.gsub(/[^0-9A-Za-z]/, '-')
  end

 def self.find_by_slug(slug)
   self.all.find do |album|
     album.slug == slug
   end
 end

end
