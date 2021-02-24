class Device < ApplicationRecord
    validates :carrier, presence: true
    validates :phone_number, phone: true

    before_validation do
        self.phone_number = DeviceHelper.format_phone(phone_number)
    end

    has_many :heartbeats
    has_many :reports
    
   
end
