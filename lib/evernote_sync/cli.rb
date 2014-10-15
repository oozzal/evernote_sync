require 'evernote_sync/storage'

module EvernoteSync
  class CLI < Thor
    include Thor::Actions

    desc 'setup', 'sets up esync with evernote credentials'
    option :key, type: :string, aliases: '-k'
    def setup
      if Storage::get_key
        if nice_yes?('Key already exists. Replace?(y/n)', Config::COLORS[:danger])
          ask_and_save_key
          nice_say Config::MSG[:setup][:replace], Config::COLORS[:danger]
        end
      else
        ask_and_save_key
        nice_say Config::MSG[:setup][:success], Config::COLORS[:success]
      end
    end

    private

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

