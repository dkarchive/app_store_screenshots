require "app_store_screenshots/version"
require "app_store_screenshots/get"

FILENAME = 'screenshots.json'

# Command line interface
module AppStoreScreenshots
  class << self
    def cli()
      print APP
      print ' '
      puts VERSION

      if ARGV.count == 0
        cli_put "Usage: #{APP} <app store url>"
        exit
      end

      id = ARGV[0].sub('id', '')
      if id.include? 'http'
        match = id.match /([0-9]*)\?/
        id = match[0].sub('?', '')
      end
      cli_put "Getting screenshots for #{id}..."

      begin
        c = File.read id
        list = JSON.parse c

        screenshots = {}
        list.each_with_index do |app_id, i|
          cli_put "#{i+1}/#{list.count}. getting screenshots for #{app_id}"
          a = AppStoreBot.new(app_id)
          screenshots[app_id]=a.get_app_data['screenshots']
          sleep 1
        end
      rescue
        a = AppStoreBot.new(id)
        screenshots = a.get_app_data['screenshots']

        list = []
        screenshots.each do |x|
          list.push "  \"#{x}\""
        end

        cli_put "Found #{screenshots.count} screenshot(s):"

        s = "[ \n"
        s << list.join(", \n")
        s << "\n]"
        puts s

        screenshots.each do |x|
          `open #{x}`
        end
      end

      File.open(FILENAME, 'w') {|f| f.write screenshots.to_json }
      cli_put "Wrote: #{FILENAME}"
    end

    def cli_put(o)
      puts "> #{o}"
    end
  end
end
