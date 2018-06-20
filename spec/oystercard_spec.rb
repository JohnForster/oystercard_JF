# frozen_string_literal: true

require 'oystercard'
# require 'journey'
# require 'journey_log'

describe Oystercard do
  let(:oystercard) { Oystercard.new }
  let(:oyster_with_min_balance) { Oystercard.new(Oystercard::MIN_BALANCE) }
  let(:oyster_with_max_balance) { Oystercard.new(Oystercard::MAX_BALANCE) }
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

    # separate tests for #in_journey?
    it 'should set in_journey to true' do
      oyster_with_max_balance
      oyster_with_max_balance.touch_in(entry_station)
      expect(oyster_with_max_balance).to be_in_journey
    end
    it 'should raise an error if balance is below minimum' do
      oystercard.instance_variable_set(:@balance, 0)
      error2 = "Balance must be above £#{Oystercard::MIN_BALANCE}."
      expect { oystercard.touch_in(entry_station) }.to raise_error(error2)
    end

    it 'calls #begin_journey on @journey_log instance' do
      journey_log = double(:journey_log)
      oyster_with_min_balance.instance_variable_set(:@journey_log, journey_log)
      expect(journey_log).to receive(:begin_journey)
      oyster_with_min_balance.touch_in("entry_station")
    end
  end

  describe '#touch_out' do
    let(:exit_station) { double :station }

    # separate tests for # in_journey?
    it 'should set in_journey to false' do
      journey = double(:journey)
      oystercard.instance_variable_set(:@current_journey, journey)
      oystercard.touch_out(exit_station)
      expect(oystercard).not_to be_in_journey
    end

    it 'should deduct the minimum fare from balance' do
      min = Journey::MINIMUM_FARE
      oyster_with_min_balance.touch_in('entry_station')
      expect { oyster_with_min_balance.touch_out('exit_station') }.to change { oyster_with_min_balance.balance }.by(-min)
    end

    # @past_journeys NOW PART OF JOURNEY_LOG
    # it 'should store the completed journey' do
    #   journey = double(:journey, end_journey: true)
    #   oystercard.instance_variable_set(:@current_journey, journey)
    #   oystercard.touch_out(exit_station)
    #   expect(oystercard.past_journeys).to include journey
    # end
  end

  describe '#list_past_journeys' do
    it 'should return an empty array before any journeys have happened' do
      expect(oystercard.list_past_journeys).to eq []
    end

    # @past_journeys NOW PART OF JOURNEY_LOG
    # it 'should return an array of past journeys' do
    #   journey = double(:journey)
    #   oystercard.instance_variable_set(:@past_journeys, [journey])
    #   expect(oystercard.list_past_journeys).to include journey
    # end

    context 'after touching in and out' do
      it 'should return completed journey' do
        oystercard.instance_variable_set(:@balance, Oystercard::MIN_BALANCE + 1)
        oystercard.touch_in(:whitechapel)
        oystercard.touch_out(:aldgate_east)
        expect(oystercard.list_past_journeys.size).to eq 1
      end
    end
  end
end
