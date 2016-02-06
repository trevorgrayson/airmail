require 'spec_helper'

describe Airmail::Sentiment do

  let(:email) { 'bob@thomas.com' }
  let(:body) { "action #{email}" }
  let(:subj) { subject.class.new('action', Airmail::EMAIL_PATTERN) }

  it 'responds true' do
    expect( subj.analyze(body) ).to be_truthy
  end

  it 'responds false' do
    expect( subj.analyze('garbage') ).to be_nil #eq(falsy)
  end

  it 'returns matches' do
    sentiments = subj.analyze(body) 
    expect(sentiments[2]).to eq(email)
  end

end

