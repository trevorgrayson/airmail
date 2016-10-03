require 'spec_helper'

describe Airmail do

  let(:mail) { :garbage }

  it 'gets TO address' do
    msg = Airmail.parse( email_fixture() )

    expect(msg.to).to eql(['trevor@trevorgrayson.com'])
    expect(msg.from).to eql(['service@paypal.com'])
    expect(msg.subject).to eql('Receipt for Your Payment to Yukaholics, Inc.')
    expect(msg.body).to be_a(Mail::Body)
  end


  def email_fixture()
    File.read('spec/fixtures/email.eml')
  end

end
