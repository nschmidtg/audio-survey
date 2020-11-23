class Song < ApplicationRecord
    belongs_to :user

    validates :recognized, inclusion: { in: [ true, false ] }
    validates :rating, presence: true
    validates :recognize_text, presence: true, if: :recognized?
    validates :memory_description, presence: true, if: -> { rating == 0 || rating == 1 }
end
