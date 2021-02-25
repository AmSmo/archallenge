require "rails_helper"

describe "Endpoint /api/terminate - Device Disable", type: :request do

    it "PATCH /api/terminate Good Params - Checks TimeStamp is correct" do
        Device.create(phone_number: "1-800-555-1234", carrier: "Cingular")
        patch "/api/terminate", params: {device_id: Device.last.id}
        expect(Device.last.disabled_at.strftime('%Y-%m-%d %H:%M:%S')).to eq(DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S'))
    end

    it "PATCH /api/terminate - Device Deactivated Already - Response 500" do
        Device.create(phone_number: "1-800-555-1234", carrier: "New England Telephone and Telegraph Company")
        Device.last.update(disabled_at: DateTime.now)
        patch "/api/terminate", params: {device_id: Device.last.id}
        expect(response).to have_http_status(500)
    end

    it "PATCH /api/terminate - No Device Found - Response 500" do
        patch "/api/terminate", params: {device_id: 1234}
        expect(response).to have_http_status(500)
    end

end