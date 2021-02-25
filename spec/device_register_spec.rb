require "rails_helper"

describe "POST /api/register", type: :request do
  context "With Good Params" do
    it "Creates Device" do
      expect {post "/api/register", 
              params: {phone_number: "1-800-555-1234", carrier: "Verizon"}
              }.to change {Device.count}.from(0).to(1) 
    end

    it "Should respond with 200 And Change Number to proper format check disabled defaults to nil" do
      post "/api/register", params: {phone_number: "1-800-555-1234", carrier: "Verizon"}
      expect(Device.last.phone_number).to eq("+18005551234")
      expect(Device.last.disabled_at).to eq(nil)
      expect(response).to have_http_status(200)
    end

    it "Should respond with 200 And Change Number to proper format" do
      post "/api/register", params: {phone_number: "(917)555-1298", carrier: "MCI"}
      expect(Device.last.phone_number).to eq("+19175551298")
      expect(response).to have_http_status(200)
    end

    it "International Number - Should respond with 200 And Change Number to proper format" do
      post "/api/register", params: {phone_number: "91 22 4085 1800", carrier: "Telecom"}
      expect(Device.last.phone_number).to eq("+912240851800")
      expect(response).to have_http_status(200)
    end

    it "Should respond with 200 And Change Number to proper format starting +1" do
      post "/api/register", params: {phone_number: "8005551234", carrier: "Verizon"}
      expect(Device.last.phone_number).to eq("+18005551234")
      expect(response).to have_http_status(200)
    end
  end

  context "Responds 500" do
    
    it "with phone number that has characters" do
      post "/api/register", params: {phone_number: "FAKE NUMBER", carrier: "NYNEX"}
      expect(response).to have_http_status(500)
    end

    it "with phone number that does not have enough numbers" do
      post "/api/register", params: {phone_number: "175554275", carrier: "Verizon"}
      expect(response).to have_http_status(500)
    end

    it "with Empty Carrier" do
      post "/api/register", params: {phone_number: "18005551234", carrier: ""}
      expect(response).to have_http_status(500)
    end
  end
end

