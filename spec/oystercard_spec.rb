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

    it 'should raise an error if trying to go above max balance' do
      error1 = "Balance cannot exceed £#{Oystercard::MAX_BALANCE}."
      expect{oystercard.top_up(Oystercard::MAX_BALANCE + 1)}.to raise_error(error1)
    end
  end
end
