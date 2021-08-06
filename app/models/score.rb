class Score < ApplicationRecord
    validates :score, numericality: { greater_than: 0}, presence: true
    validates :player, :time, presence: true
end
