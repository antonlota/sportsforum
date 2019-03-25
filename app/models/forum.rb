class Forum < ApplicationRecord
    has_many :subthreads, dependent: :destroy
end
