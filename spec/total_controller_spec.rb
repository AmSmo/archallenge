require "rails_helper"

RSpec.describe Api::DeviceController, type: :controller do
  describe "POST register" do
    it "returns a 200" do
      post :register, params: {phone_number: "18005551234", carrier: "MSN"}
      expect(response).to have_http_status(200)
    end
    
    it "returns a 500" do
      post :register, params: {phone_number: "105551234", carrier: "MSN"}
      expect(response).to have_http_status(500)
    end
    
    it "returns a 500" do
      get :register
      expect(response).to have_http_status(500)
    end

    it "returns a 500" do
      post :register, params: {phone_number: "18005551234", carrier: ""}
      expect(response).to have_http_status(500)
    end
    
    it "returns a 500" do
      post :register, params: {phone_number: "", carrier: "MA Bell"}
      expect(response).to have_http_status(500)
    end
  end

  describe "PATCH terminate" do
    it "returns a 200" do
      device = Device.create(phone_number: "18005551234", carrier: "Bell Telephone")
      patch :terminate, params: {device_id: device.id}
      expect(response).to have_http_status(200)
    end
    
    it "returns a 500" do
      patch :terminate, params: {device_id: 1234}
      expect(response).to have_http_status(500)
    end

    it "returns a 500" do
      device = Device.create(phone_number: "18005551234", carrier: "Bell Telephone")
      get :terminate
      expect(response).to have_http_status(500)
    end

    it "returns a 500" do
      device = Device.create(phone_number: "18005551234", carrier: "Bell Telephone")
      device.update(disabled_at: DateTime.now)
      patch :terminate, params: {device_id: device.id}
      expect(response).to have_http_status(500)
    end
  end

  describe "POST alive" do
    it "returns a 200" do
      device = Device.create(phone_number: "8005551234", carrier: "Bell Telephone")
      post :alive, params: {device_id: device.id}
      expect(response).to have_http_status(200)
    end
    
    it "returns a 500" do
      post :alive, params: {device_id: 1234}
      expect(response).to have_http_status(500)
    end

    it "returns a 500" do
      device = Device.create(phone_number: "+1-900-555-1234", carrier: "Bell Telephone")
      device.update(disabled_at: DateTime.now)
      post :alive, params: {device_id: device.id}
      expect(response).to have_http_status(500)
    end
  end

  describe "POST report" do
    it "returns a 200" do
      device = Device.create(phone_number: "8005551234", carrier: "Bell Telephone")
      post :report, params: {device_id: device.id, message: "⬆⬆⬇⬇⬅➡⬅➡🅱🅰", sender: "Konami"}
      expect(response).to have_http_status(200)
    end

    it "returns a 500" do
      device = Device.create(phone_number: "8005551234", carrier: "Bell Telephone")
      post :report, params: {device_id: device.id, message: "⬆⬆⬇⬇⬅➡⬅➡🅱🅰", sender: ""}
      expect(response).to have_http_status(500)
    end

    it "returns a 500" do
      post :report, params: {device_id: 1234, message: "⬆⬆⬇⬇⬅➡⬅➡🅱🅰", sender: "Konami"}
      expect(response).to have_http_status(500)
    end

    it "returns a 500" do
      device = Device.create(phone_number: "8005551234", carrier: "Bell Telephone")
      post :report, params: {device_id: device.id, message: "", sender: "Konami"}
      expect(response).to have_http_status(500)
    end

    it "returns a 500" do
      get :report
      expect(response).to have_http_status(500)
    end
  end


end