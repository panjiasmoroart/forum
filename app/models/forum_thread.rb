class ForumThread < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  has_many :forum_posts, dependent: :destroy 

  validates :title, presence: true, length: {maximum: 75} 
  validates :content, presence: true

  def sticky?
    sticky_order != 100
  end

  def pinit!
    sticky_order == 100 ? self.sticky_order = 1 : self.sticky_order = 100
    self.save  
  end
end
