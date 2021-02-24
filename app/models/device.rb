class Device < ApplicationRecord
    validates :carrier, presence: true
    has_many :heartbeats
    has_many :reports
end
