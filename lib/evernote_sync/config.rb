module EvernoteSync
  module Config
    BASE_PATH = File.expand_path('~/.esync')
    KEY_FILE = '.key'
    KEY_PATH = File.join(BASE_PATH, KEY_FILE)

    COLORS = {
      danger: :red,
      success: :green,
      alert: :yellow
    }

    MSG = {
      setup: {
        success: 'Key setup successful',
        replace: 'Key replaced'
      }
    }

  end
end

