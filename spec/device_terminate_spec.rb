require "rails_helper"

describe "PATCH /api/terminate", type: :request do
  context "Good Params" do
    it "Have correct TimeStamp at disabled at" do
        Device.create(phone_number: "1-800-555-1234", carrier: "Cingular")
        patch "/api/terminate", params: {device_id: Device.last.id}
        expect(Device.last.disabled_at.strftime('%Y-%m-%d %H:%M:%S')).to eq(DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S'))
    end
  end

  context "Respond 500" do
    it "with Device Deactivated Already" do
        Device.create(phone_number: "1-800-555-1234", carrier: "New England Telephone and Telegraph Company")
        Device.last.update(disabled_at: DateTime.now)
        patch "/api/terminate", params: {device_id: Device.last.id}
        expect(response).to have_http_status(500)
    end

    it "with No Device Found" do
        patch "/api/terminate", params: {device_id: 1234}
        expect(response).to have_http_status(500)
    end
  end
end