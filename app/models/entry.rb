class Entry < ActiveRecord::Base
  belongs_to :user
  validates :content, :date, presence:true

end
