require 'json'
require 'net/http'
require 'openssl'

# Get app store screenshots.
module AppStoreScreenshots
  class Get
    def initialize(app_id, app_country='us')
      @app_id = app_id
      @app_country = app_country

      @itunes_domain_url = 'itunes.apple.com'
      @itunes_http_options = {'User-Agent' => 'iTunes/11.1.5 (Macintosh; OS X 10.9.2) AppleWebKit/537.74.9'}

      @app_data = {}
      get_app_info
    end

    def error
      @app_data['screenshots'].count==0
    end

    def response
      @app_data['response']
    end

    def screenshots
      @app_data['screenshots']
    end

    def urls
      @app_data['urls']
    end

    private

    def get_app_info
      http = Net::HTTP.new(@itunes_domain_url, Net::HTTP.https_default_port())
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE # disable ssl certificate check

      path = "/#{@app_country}/app/id#{@app_id}"

      response = http.request( Net::HTTP::Get.new( path + "&appVersion=current" , @itunes_http_options) )

      if response.code != '200'
        puts "App Store store website communication (status-code: #{response.code})\n#{response.body}"
      else
        @app_data['response'] = response.body

        data = extract_app_data_from_raw_json( response.body )
        @app_data['screenshots'] = data
      end

      data
    end

    def extract_app_data_from_raw_json(data)
      list = data.split 'url'

      shots = []

      # look for screenshots with large size
      list.each do |x|
        if shots.count<5
          shots.push x.match('http.*jpeg')[0] if x.include?('mzstatic') && x.include?('696x')
        end
      end

      # look for any screenshots
      if shots.count==0
        list.each do |x|
          if shots.count<5
            shots.push x.match('http.*jpeg')[0] if x.include?('mzstatic')
          end
        end
      end

      @app_data['urls'] = list if shots.count == 0

      shots
    end
  end
end
