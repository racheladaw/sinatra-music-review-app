class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true
  validates :username, uniqueness: true
  has_many :reviews
  has_many :albums, through: :reviews

  def slug
   self.username.downcase.gsub(/[^0-9A-Za-z]/, '-')
  end

 def self.find_by_slug(slug)
   self.all.find do |user|
     user.slug == slug
   end
 end
end
