require "rails_helper"

describe "POST /api/report - Report Create", type: :request do
  context "Good Params" do
    it "Creates Report" do
        device = Device.create(phone_number: "8008675309", carrier:"Jenny")
        expect {post "/api/report", 
                params: {message: "SOS", sender:"Wilson", device_id: device.id}
                }.to change {Report.count}.from(0).to(1) 
        expect(response).to have_http_status(200)
    end 

    it "Creates Report and accepts Emojis" do
        device = Device.create(phone_number: "8008675309", carrier:"Jenny")
        post "/api/report", 
                params: {message: "⁣
                                  🎈🎈  ☁️
                                 🎈🎈🎈
                         ☁️     🎈🎈🎈🎈
                                🎈🎈🎈🎈
                           ☁️    ⁣🎈🎈🎈
                                   \|/
                                   🏠   ☁️
                           ☁️         ☁️

                        🌳🌹🏫🌳🏢🏢_🏢🏢🌳🌳",
            sender:"Squirrel", device_id: device.id}
                
        expect(Report.last.message).to eq("⁣
                                  🎈🎈  ☁️
                                 🎈🎈🎈
                         ☁️     🎈🎈🎈🎈
                                🎈🎈🎈🎈
                           ☁️    ⁣🎈🎈🎈
                                   \|/
                                   🏠   ☁️
                           ☁️         ☁️

                        🌳🌹🏫🌳🏢🏢_🏢🏢🌳🌳")
        expect(response).to have_http_status(200)
    end 
  end

  context "Returns 500" do
    it "with Disabled Device" do
        device = Device.create(phone_number: "8008675309", carrier:"Jenny")
        device.update(disabled_at: DateTime.now)
        post "/api/report", 
                params: {message: "SOS", sender:"Wilson", device_id: device.id}
        expect(response).to have_http_status(500)
    end 

    it "with Blank Message" do
        device = Device.create(phone_number: "8008675309", carrier:"Jenny")
        post "/api/report", 
                params: {message: "", sender:"Wilson", device_id: device.id}
        expect(response).to have_http_status(500)
    end 

    it "with Blank Sender" do
        device = Device.create(phone_number: "8008675309", carrier:"Jenny")
        post "/api/report", 
                params: {message: "In a bottle", sender:"", device_id: device.id}
        expect(response).to have_http_status(500)
    end 

    it "with Bad Device ID" do
        post "/api/report", 
                params: {message: "In a bottle", sender:"Sting", device_id: 1234}
        expect(response).to have_http_status(500)
    end 
  end
end
