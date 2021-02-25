require "rails_helper"

describe "Heartbeat Create", type: :request do
  context "Post /api/alive" do
    context "With Good Params" do
        it "Responds 200" do
            Device.create(phone_number: "1-800-555-1234", carrier: "Verizon")
            post "/api/alive", params: {device_id: Device.last.id}
            expect(response).to have_http_status(200)
        end
        
        it "Creates Heartbeat" do
            Device.create(phone_number: "1-800-555-1234", carrier: "Verizon")
            expect {post "/api/alive", 
                    params: {device_id: Device.last.id}
                    }.to change {Heartbeat.count}.from(0).to(1) 
        end

        it "Checks TimeStamp is correct" do
            Device.create(phone_number: "1-800-555-1234", carrier: "Verizon")
            post "/api/alive", params: {device_id: Device.last.id}
            expect(Heartbeat.last.created_at.strftime('%Y-%m-%d %H:%M:%S')).to eq(DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S'))
        end
    end

    context "Responds 500" do 
        it "With Bad Device ID" do
            post "/api/alive", params: {device_id: 1234}
            expect(response).to have_http_status(500)
        end

        it "With Device Deactivated" do
            Device.create(phone_number: "1-800-555-1234", carrier: "Verizon")
            Device.last.update(disabled_at: DateTime.now)
            post "/api/alive", params: {device_id: Device.last.id}
            expect(response).to have_http_status(500)
        end
    end
  end

end