class Song < ApplicationRecord
    belongs_to :user

    enum rating_strings: [ I18n.t(:yes_label).to_sym, I18n.t(:somewhat_label).to_sym, I18n.t(:no_label).to_sym ], _prefix: true
    enum yes_no_strings: [ I18n.t(:yes_label).to_sym, I18n.t(:no_label).to_sym], _prefix: true

    validates :recognized, inclusion: { in: [ true, false ] }
    validates :rating, presence: true
    validates :recognize_text, presence: true, if: :recognized?
    validates :memory_description, presence: true, if: -> { rating == 0 || rating == 1 }
end
