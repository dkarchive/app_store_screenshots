require 'json'
require 'net/http'
require 'openssl'

require 'awesome_print'

# Get app store screenshots.
class AppStoreBot
  def initialize(app_id, app_country='us')
    @app_id = app_id
    @app_country = app_country

    @itunes_domain_url = 'itunes.apple.com'
    @itunes_http_options = {'User-Agent' => 'iTunes/11.1.5 (Macintosh; OS X 10.9.2) AppleWebKit/537.74.9'}
    @itunes_reviews_url = ''

    @app_data = {}
    get_app_info
  end

  def get_app_data
    @app_data
  end

  # def update_app_data
  #   get_app_info
  #   @app_data
  # end

  def get_screenshots
    @app_data['screenshots']
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
      data = extract_app_data_from_raw_json( response.body )
      @app_data['screenshots'] = data
    end

    data
  end

  def extract_app_data_from_raw_json(data)
    list = data.split 'url'

    a4 = []
    list.each do |x|
      if a4.count<5
        a4.push x.match('http.*jpeg')[0] if x.include?('mzstatic') && x.include?('696x')
      end
    end

    if a4.count==0
      ap list
      list.each do |x|
        if a4.count<5
          a4.push x.match('http.*jpeg')[0] if x.include?('mzstatic')
        end
      end
    end

    a4
  end

  def set_itunes_review_url_path(url)
    if url
      index = url.index(@itunes_domain_url)
      @itunes_reviews_url = url[index, url.length].sub! @itunes_domain_url, ""
    else
      puts 'Please provide a valid URL string.'
    end
  end
end
