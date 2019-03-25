class Subthread < ApplicationRecord
  belongs_to :user
  belongs_to :forum
  has_many :comments, dependent: :destroy
  validates :content, presence: true, length: { in: 2..1000 }
end
