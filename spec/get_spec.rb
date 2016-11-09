require 'app_store_screenshots'

describe AppStoreScreenshots do
  describe "get" do

    context "given the instagram itunes id" do
      id = '389801252'
      value = AppStoreScreenshots::Get.new(id).screenshots.count
      expected = 5
      it "finds the screenshots" do
        expect(value).to eql(expected)
      end
    end

    context "given the instagram itunes id" do
      id = '389801252'
      value = AppStoreScreenshots::Get.new(id).error
      expected = false
      it "no error" do
        expect(value).to eql(expected)
      end
    end
    
    context "given invalid id" do
      id = '123'
      value = AppStoreScreenshots::Get.new(id).screenshots.count
      expected = 0
      it "finds no screenshots" do
        expect(value).to eql(expected)
      end
    end

    context "given invalid id" do
      id = '123'
      value = AppStoreScreenshots::Get.new(id).error
      expected = true
      it "has error" do
        expect(value).to eql(expected)
      end
    end

  end
end
