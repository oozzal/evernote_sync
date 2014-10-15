require 'evernote_sync/config'

module EvernoteSync
  module Storage
    extend self

    def get_key
      File.read(Config::KEY_PATH) rescue false
    end

    def save_key(key)
      FileUtils.mkdir(Config::BASE_PATH) unless File.exists?(Config::BASE_PATH)
      File.open(Config::KEY_PATH, 'w') { |f| f.write(key) }
    end

  end
end

