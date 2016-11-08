require 'app_store_screenshots'

describe AppStoreScreenshots do
  describe "cli id" do

    context "given an itunes url" do
      input = 'https://itunes.apple.com/us/app/instagram/id389801252?mt=8'
      value = AppStoreScreenshots.cli_id input
      expected = '389801252'
      it "finds the id" do
        expect(value).to eql(expected)
      end
    end

    context "given part of an itunes url" do
      input = 'id389801252?mt=8'
      value = AppStoreScreenshots.cli_id input
      expected = '389801252'
      it "finds the id" do
        expect(value).to eql(expected)
      end
    end

    context "given an id" do
      input = '389801252'
      value = AppStoreScreenshots.cli_id input
      expected = '389801252'
      it "validates" do
        expect(value).to eql(expected)
      end
    end

    context "given a string with id" do
      input = 'id389801252'
      value = AppStoreScreenshots.cli_id input
      expected = '389801252'
      it "finds the id" do
        expect(value).to eql(expected)
      end
    end

    context "given a string without id" do
      input = 'kjlda'
      value = AppStoreScreenshots.cli_id input
      expected = 'Error'
      it "finds an error" do
        expect(value).to include(expected)
      end
    end

  end
end
