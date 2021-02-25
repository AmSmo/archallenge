class Report < ApplicationRecord
  belongs_to :device
  validates :sender, presence: true
  validates :message, presence: true
end
