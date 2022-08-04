class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :comments,dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :taggings, dependent: :destroy
  def liked_by?(post_id)
    likes.where(post_id: post_id).exists?
  end

  attachment :image
  def active_for_authentication?
    super && (self.is_deleted == false)
  end
end
