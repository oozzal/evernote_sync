require 'evernote_sync/storage'

module EvernoteSync
  class CLI < Thor
    include Thor::Actions

    desc 'setup', 'sets up esync with evernote credentials'
    option :key, type: :string, aliases: '-k'
    def setup
      if Storage::key_exists?
        if nice_yes?('Key already exists. Replace?(y/n)', Config::COLORS[:danger])
          ask_and_save_key
          nice_say Config::MSG[:setup][:replace], Config::COLORS[:danger]
        end
      else
        ask_and_save_key
        nice_say Config::MSG[:setup][:success], Config::COLORS[:success]
      end
    end

    desc 'search query', 'Search evernote'
    option :tag, type: :string, aliases: '-t'
    # option :notebook, type: :string, aliases: '-n'
    def search(query)
      alert_setup_incomplete && return unless is_setup_ok?
      client = get_client
      query = "tag:#{query}" if options[:tag]
      client.search query
    end

    private

    def alert_setup_incomplete
      nice_say Config::MSG[:setup][:incomplete], Config::COLORS[:danger]
    end

    def get_client
      Client.new Storage::get_key
    end

    def is_setup_ok?
      Storage::key_exists?
    end

    ## Command line interaction methods
    def ask_and_save_key
      key = options[:key] || nice_ask('Please enter your key. It will be hidden in terminal.', Config::COLORS[:alert], echo: false)
      Storage::save_key key
    end

    def nice_yes?(msg, *args)
      yes? nice_msg(msg) + '>>', *args
    end

    def nice_ask(msg, *args)
      ask nice_msg(msg) + '>>', *args
    end

    def nice_say(msg, *args)
      say nice_msg(msg), *args
    end

    def nice_msg(msg)
      nice_msg = "\n"
      nice_msg += "-" * (msg.length + 4)
      nice_msg += "\n| #{msg} |\n"
      nice_msg += "-" * (msg.length + 4)
      nice_msg += "\n"
    end
  end
end

