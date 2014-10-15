require 'spec_helper'

describe EvernoteSync::Storage do
  include EvernoteSync::Storage

  let(:key) { 'oozzal' }

  let(:base_path) { File.expand_path('../../tmp/.esync', __FILE__) }

  before do
    stub_const('EvernoteSync::Config::BASE_PATH', base_path)
    stub_const('EvernoteSync::Config::KEY_PATH', File.join(base_path, EvernoteSync::Config::KEY_FILE))
  end

  after(:each) { FileUtils.rm_rf base_path }

  describe '.get_key' do
    context 'when key does not exist' do
      it 'returns false' do
        expect(subject.get_key).to eql false
      end
    end

    context 'when key exists' do
      before do
        allow(File).to receive(:read).with(EvernoteSync::Config::KEY_PATH).and_return key
      end

      it 'reads the key from the key file' do
        expect(subject.get_key).to eql key
      end
    end
  end

  describe '.save_key' do
    it 'saves key to the key file' do
      subject.save_key key
      expect(subject.get_key).to eql key
    end

    context 'when base path does not exist' do
      it 'creates the base path and saves the key' do
        subject.save_key key
        # cannot expect to receive since we need to create the directory
        expect(File.exists? base_path).to eql true
      end
    end

    context 'when base path exists' do
      before { FileUtils.mkdir(EvernoteSync::Config::BASE_PATH) }

      it 'does not create the base path' do
        expect(FileUtils).not_to receive(:mkdir)
        subject.save_key key
      end

      context 'when key does not exist' do
        it 'saves the key' do
          subject.save_key key
          expect(subject.get_key).to eql key
        end
      end

      context 'when key exists' do
        let(:new_key) { 'nanu' }
        before { subject.save_key key }

        it 'replaces the old key' do
          subject.save_key new_key
          expect(subject.get_key).to eql new_key
        end
      end
    end
  end
end

