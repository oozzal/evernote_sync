require 'spec_helper'

describe EvernoteSync::Storage do
  include EvernoteSync::Storage

  let(:key) { 'oozzal' }
  let(:config) { EvernoteSync::Config }

  let(:base_path) { File.expand_path('../../tmp/.esync', __FILE__) }
  let(:key_path) { File.join(base_path, config::KEY_FILE) }

  before do
    stub_const('EvernoteSync::Config::BASE_PATH', base_path)
    stub_const('EvernoteSync::Config::KEY_PATH', key_path)
  end

  describe '.get_key' do
    context 'when key does not exist' do
      it 'returns false' do
        expect(subject.get_key).to eql false
      end
    end

    context 'when key exists' do
      before do
        allow(File).to receive(:read).with(config::KEY_PATH).and_return key
      end

      it 'reads the key from the key file' do
        expect(subject.get_key).to eql key
      end
    end
  end

  describe '.save_key' do
    before do
      file = double('file')
      expect(File).to receive(:open).with(key_path, 'w').and_yield(file)
      expect(file).to receive(:write).with(key)
    end

    context 'when base path does not exist' do
      before do
        allow(File).to receive(:exists?).with(base_path).and_return false
      end

      it 'creates the base path and saves the key' do
        expect(FileUtils).to receive(:mkdir).with(base_path)
        subject.save_key key
      end
    end

    context 'when base path exists' do
      before do
        allow(File).to receive(:exists?).with(base_path).and_return true
      end

      it 'does not create the base path but saves the key' do
        expect(FileUtils).not_to receive(:mkdir)
        subject.save_key key
      end
    end
  end
end

