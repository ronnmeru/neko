class Post < ApplicationRecord
 has_many :likes, dependent: :destroy
 has_many :comments, dependent: :destroy
 has_many :taggings, dependent: :destroy
 belongs_to :user
  attachment :image # ここを追加（_idは含めません）
  acts_as_taggable #追加
  # acts_as_taggable_on :tags　と同じ意味のエイリアス
end
