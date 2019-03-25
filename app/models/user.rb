class User < ApplicationRecord
  has_secure_password
  has_many :subthreads, dependent: :destroy
  has_many :comments, dependent: :destroy

  # EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
    validates :first_name, :last_name, presence: true, length: { in: 2..20 }
    validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { in: 5..20 }
    validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { in: 2..20 }
    validates :password, presence: true, length: { in: 5..20 }
end
