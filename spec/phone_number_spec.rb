describe DeviceHelper do

  describe "transforms foreign number" do    
    context "given an British phone number" do    
      it "formatted number" do
        expect(DeviceHelper.format_phone(("44 7911 123456"))).to eq("+447911123456")
      end
    
    end  
  end

  describe "transforms US number" do    
    context "given an US phone number formatted number" do      
      it "without 1" do
        expect(DeviceHelper.format_phone(("(917) 867 5309"))).to eq("+19178675309")
      end
    
      it "with dashes " do
        expect(DeviceHelper.format_phone(("1-800-867-5309"))).to eq("+18008675309")
      end
    end

    context "returns false" do       
      it "for invalid number" do
        expect(DeviceHelper.format_phone(("00-867-5309"))).to eq(false)
      end

      it "for empty string" do
        expect(DeviceHelper.format_phone((""))).to eq(false)
      end    
    end
  
  end
  
end