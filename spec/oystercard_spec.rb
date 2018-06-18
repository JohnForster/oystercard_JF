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
      expect { oystercard.top_up(3) }.to change { oystercard.balance }.by(3)
    end

    it 'should raise an error if trying to go above max balance' do
      error1 = "Balance cannot exceed £#{Oystercard::MAX_BALANCE}."
      excess = Oystercard::MAX_BALANCE + 1
      expect { oystercard.top_up(excess) }.to raise_error(error1)
    end
  end

  describe '#deduct' do
    it 'should decrease balance by given amount' do
      expect { oystercard.deduct(3) }.to change { oystercard.balance }.by(-3)
    end
  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?) }
  end

  describe '#touch_in' do
    it 'should set in_journey to true' do
      oystercard.touch_in
      expect(oystercard).to be_in_journey
    end
  end

  describe '#touch_out' do
    it 'should set in_journey to false' do
      oystercard.instance_variable_set(:@in_journey, true)
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end
  end
end
