module DeviceHelper
    def self.format_phone(phone_number)

        # only discovered a bug after trying to use my own phone number, it tried to convert it to an India area code
        only_numbers = phone_number.gsub(/[^\d]/, '')
        if only_numbers.starts_with?("91") && only_numbers.length == 10
            return "+1#{only_numbers}"
        end
        
        phone = Phonelib.parse(phone_number)
        if phone.valid?
            return phone.e164
        elsif phone.valid_for_country?("US")
            americanized_phone = Phonelib.parse(phone_number, "US")
            return americanized_phone.e164
        else
            return false
        end
    end
end