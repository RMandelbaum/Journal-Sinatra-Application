class User < ActiveRecord::Base
  has_many :entries

  has_secure_password
  validates :username, :email, presence: true
  validates :username, :email, uniqueness:true

    def slug
      username.downcase.gsub(" ","-")
    end

    def self.find_by_slug(slug)
      User.all.find{|user| user.slug == slug}
    end
end
