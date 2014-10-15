require 'spec_helper'
require 'support/fake_web'
require 'support/capture'

describe EvernoteSync::CLI do
  describe '#setup' do
    let(:storage) { EvernoteSync::Storage }
    let(:config) { EvernoteSync::Config }
    let(:key) { 'abc' }
    let(:output) { capture(:stdout) { subject.setup } }

    context 'when key does not exist' do
      before do
        allow(storage).to receive(:get_key).and_return false
        expect(subject).to receive(:nice_say).with(config::MSG[:setup][:success], config::COLORS[:success])
      end

      context 'when key is provided' do
        before { subject.options = {key: key} }

        it 'does not ask for key' do
          expect(subject).not_to receive(:nice_ask)
          subject.setup
        end

        it 'saves the key from the command line argument' do
          expect(storage).to receive(:save_key).with(key)
          subject.setup
        end
      end

      context 'when key is not provided' do
        it 'asks user to enter key' do
          expect(subject).to receive(:nice_ask)
          subject.setup
        end

        it 'saves the key from user prompt' do
          allow(subject).to receive(:nice_ask).and_return key
          expect(storage).to receive(:save_key).with(key)
          subject.setup
        end
      end
    end

    context 'when key exists' do
      before do
        allow(storage).to receive(:get_key).and_return key
      end

      context 'when user does not want to replace the key' do
        before do
          allow(subject).to receive(:nice_yes?).and_return false
        end

        it 'does not replace the key' do
          expect(storage).not_to receive(:save_key).with key
          expect(output).to be_empty
        end
      end

      context 'when user wants to replace the key' do
        before do
          allow(subject).to receive(:nice_yes?).and_return true
          expect(subject).to receive(:nice_say).with(config::MSG[:setup][:replace], config::COLORS[:danger])
        end

        context 'when key is not provided' do
          it 'asks user for new key' do
            expect(subject).to receive(:nice_ask)
            subject.setup
          end

          it 'replaces the key' do
            allow(subject).to receive(:nice_ask).and_return key
            expect(storage).to receive(:save_key).with key
            subject.setup
          end
        end
      end
    end

  end
end

