require 'spec_helper'

describe Airmail do

  let(:mail) { :garbage }

  it 'sets route' do
    Airmail.route do 
      Counter.inc
    end

    expect(Airmail.class_variable_get(:@@route)).to be_a(Proc)
  end

  context 'received email' do

    before :each do
      Counter.reset

      Airmail.route do 
        Counter.inc
      end

      Airmail.receive(mail)
    end 

    it 'runs route' do
      expect(Counter.count).to eq(1)
    end

    it 'runs route for each mail' do
      Airmail.receive(mail)
      expect(Counter.count).to eq(2)
    end

  end

  context 'multiple controllers' do

    it 'delivers once' do
      Counter.reset

      Airmail.route do 
        deliver CountController
        deliver CountController
      end

      Airmail.receive(mail)
      expect(Counter.count).to eq(1)
    end

    it 'delivers to the first controller' do
      Counter.reset

      Airmail.route do 
        deliver BlankController
        deliver CountController
      end

      Airmail.receive(mail)
      expect(Counter.count).to eq(0)
    end

    it 'delivers to the first controller' do
      Counter.reset

      Airmail.route do 
        deliver CountController
        deliver BlankController
      end

      Airmail.receive(mail)
      expect(Counter.count).to eq(1)
    end

  end

end
