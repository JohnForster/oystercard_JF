require 'oystercard'

describe Oystercard do
  let(:oystercard) { Oystercard.new }
  describe '#balance' do
    it 'should have an initial value of 0' do
      expect(oystercard.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'should increase balance by given amount' do
      expect{ oystercard.top_up(3) }.to change{ oystercard.balance }.by(3)
    end
  end
end
