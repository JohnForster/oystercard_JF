# frozen_string_literal: true

require 'oystercard'
require 'journey'

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
    Oystercard.send(:public, :deduct)
    it 'should decrease balance by given amount' do
      expect { oystercard.deduct(3) }.to change { oystercard.balance }.by(-3)
    end
  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?) }
  end

  describe '#touch_in' do
    let(:entry_station) { double :station }
    it 'should set in_journey to true' do
      oystercard.instance_variable_set(:@balance, 1)
      oystercard.touch_in(entry_station)
      expect(oystercard).to be_in_journey
    end
    it 'should raise an error if balance is below minimum' do
      oystercard.instance_variable_set(:@balance, 0)
      error2 = "Balance must be above £#{Oystercard::MIN_BALANCE}."
      expect { oystercard.touch_in(entry_station) }.to raise_error(error2)
    end
    it 'should record the entry station' do
      oystercard.instance_variable_set(:@balance, Oystercard::MIN_BALANCE + 1)
      expect(Journey).to receive(:new).with(entry_station)
      oystercard.touch_in(entry_station)
    end
  end

  describe '#touch_out' do
    let(:exit_station) { double :station }
    it 'should set in_journey to false' do
      journey = double(:journey)
      oystercard.instance_variable_set(:@current_journey, journey)
      oystercard.touch_out(exit_station)
      expect(oystercard).not_to be_in_journey
    end

    it 'should deduct the minimum fare from balance' do
      min = Journey::MINIMUM_FARE
      expect { oystercard.touch_out(exit_station) }.to change { oystercard.balance }.by(-min)
    end

    it 'should store the completed journey' do
      journey = double(:journey, end_journey: true)
      oystercard.instance_variable_set(:@current_journey, journey)
      oystercard.touch_out(exit_station)
      expect(oystercard.past_journeys).to include journey
    end
  end

  describe '#list_past_journeys' do
    it 'should return an array of past journeys' do
      journey = double(:journey)
      oystercard.instance_variable_set(:@past_journeys, [journey])
      expect(oystercard.list_past_journeys).to include journey
    end
  end
end
