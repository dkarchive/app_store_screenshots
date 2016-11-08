require "app_store_screenshots/version"
require "app_store_screenshots/get"

FILEBASE = 'screenshots'
OPT_OPEN = 'open'
OPT_SAVE = 'save'

# Command line interface.
module AppStoreScreenshots
  class << self
    def cli()
      cli_put "#{APP} #{VERSION}"

      if ARGV.count == 0
        cli_put "Usage: #{APP} <app store url> [--#{OPT_OPEN}] [--#{OPT_SAVE}]"
        exit
      end

      input = ARGV[0]
      id = cli_id(input)
      if id.include? 'Error'
        cli_put id
        exit
      end

      cli_put "Getting screenshots for #{id}..."

      g = Get.new(id)
      screenshots = g.screenshots

      list = []
      screenshots.each do |x|
        list.push "  \"#{x}\""
      end

      cli_put "Found #{screenshots.count} screenshot(s):"

      s = "[ \n"
      s << list.join(", \n")
      s << "\n]"
      puts s

      if ARGV.join(' ').include? OPT_OPEN
        cli_put 'Opening screenshots in browser...'
        screenshots.each do |x|
          `open #{x}`
        end
      end

      if ARGV.join(' ').include? OPT_SAVE
        cli_put 'Saving screenshots...'

        curl_string = cli_curl_string screenshots, id
        `#{curl_string}`
      end

      fn = "#{FILEBASE}-#{id}.json"
      File.open(fn, 'w') {|f| f.write screenshots.to_json }
      # cli_put "Wrote: #{fn}"

      fn
    end

    def cli_put(o)
      puts "> #{o}"
    end

    def cli_curl_string(list, id)
      curl_string = 'curl'
      list.each_with_index do |x, i|
        begin
          ext = x.match(/[^\.]+$/)[0]
        rescue
          ext = 'jpeg'
        end

        curl_string << ' -o'
        curl_string << " #{id}-#{i}.#{ext} #{x}"
      end

      curl_string
    end

    def cli_id(input)
      id = input.sub('id', '')
      if id.include?('http') || id.include?('?')
        match = id.match /([0-9]*)\?/
        if match.nil?
          return "Error: could not find id in #{id}"
        end
        id = match[0].sub('?', '')
      end

      valid = id.to_i
      unless valid>0
        return "Error: #{id} is not a valid id"
      end

      id
    end
  end
end
