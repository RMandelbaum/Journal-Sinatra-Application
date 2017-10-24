class Entry < ActiveRecord::Base
  belongs_to :user
  validates :date, :content, presence:true

  
end
