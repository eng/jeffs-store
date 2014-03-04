require 'spec_helper' 

describe Product do
  describe :validation do
    it "can pass" do
      p = FactoryGirl.build(:product)
      p.valid?.should be_true
    end

    it "requires a name and price" do
      p = Product.new
      p.valid?.should be_false
      p.errors.messages[:name].should be_present
      p.errors.messages[:price].should be_present
    end
  end
 
end
