require 'spec_helper'

describe Airmail do
  context 'multiple controllers' do

    let(:mail) { Mail.new(body: "include bob@thomas.com") }
    let(:subscribe_mail) { Mail.new(body: "subscribe bob@thomas.com") }

    it 'matches sentiment' do
      Counter.reset

      Airmail.route do 
        if sentiment "include", Airmail::EMAIL_PATTERN
          deliver CountController
        end
      end

      Airmail.receive(mail)
      expect(Counter.count).to eq(1)
    end

    it 'matches word bag sentiment' do
      
      Counter.reset

      Airmail.route do 
        if sentiment ["include", "subscribe"], Airmail::EMAIL_PATTERN
          deliver CountController
        end
      end

      Airmail.receive(mail)
      expect(Counter.count).to eq(1)

      Airmail.receive(subscribe_mail)
      expect(Counter.count).to eq(2)
    end

    it 'rejects mismatched sentiment' do
      Counter.reset

      Airmail.route do 
        if sentiment "alksfdlaklsdfjslf" 
          deliver CountController
        end
      end

      Airmail.receive(mail)
      expect(Counter.count).to eq(0)
    end

  end

end
