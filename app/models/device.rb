class Device < ApplicationRecord
    validates :carrier, presence: true

    has_many :heartbeats
end
