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
      id = input.sub('id', '')
      if id.include? 'http'
        match = id.match /([0-9]*)\?/
        if match.nil?
          cli_put "Error: could not find id in #{id}"
          exit
        end
        id = match[0].sub('?', '')
      end

      valid = id.to_i
      unless valid>0
        cli_put "Error: #{id} is not a valid id"
        exit
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
        screenshots = a.get_screenshots

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
          screenshots.each_with_index do |x, i|
            ext = 'jpeg'
            `curl -o #{id}-#{i}.#{ext} #{x}`
          end
        end
      end

      fn = "#{FILEBASE}-#{id}.json"
      File.open(fn, 'w') {|f| f.write screenshots.to_json }
      # cli_put "Wrote: #{fn}"

      fn
    end

    def cli_put(o)
      puts "> #{o}"
    end
  end
end
