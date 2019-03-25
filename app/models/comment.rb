class Comment < ApplicationRecord
  belongs_to :subthread
  belongs_to :user


  validates :content, presence: true, length: { in: 2..50 }
end
