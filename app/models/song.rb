class Song < ApplicationRecord
    belongs_to :user

    enum rating_strings: [ 'strong'.to_sym, 'somewhat'.to_sym, 'no association'.to_sym ]

    validates :recognized, presence: true
    validates :rating, presence: true
    validates :recognize_text, presence: true, if: :recognized?
    validates :memory_description, presence: true, if: -> { rating == 0 || rating == 1 }
end
