require 'spec_helper'

describe EvernoteSync::Config do
  include EvernoteSync::Config

  it 'has a base path' do
    expect(subject::BASE_PATH).not_to be_nil
  end

  it 'has a key file' do
    expect(subject::KEY_FILE).not_to be_nil
  end

  it 'has a key path' do
    expect(subject::KEY_PATH).not_to be_nil
  end

  it 'has colors' do
    expect(subject::COLORS).to be_a Hash
  end

  it 'has messages' do
    expect(subject::MSG).to be_a Hash
  end

  it 'has setup messages' do
    expect(subject::MSG[:setup]).to be_a Hash
  end
end

