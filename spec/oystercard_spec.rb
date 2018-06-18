require 'oystercard'

describe Oystercard do
  let(:oystercard) { Oystercard.new }
  describe '#balance' do
    it 'should have an initial value of 0' do
      expect(oystercard.balance).to eq 0
    end
  end
end
