class JourneyLog
  attr_reader :current_journey, :past_journeys, :in_journey
  def initialize(journey_class)
    @current_journey = nil
    @past_journeys = []
  end

  def begin_journey(entry_station)
    @current_journey = Journey.new(entry_station)
  end

  def end_journey(exit_station)
    create_finished_journey(exit_station) if !@current_journey
    @current_journey.complete(exit_station)
    reset
  end

  def last_fare
    @past_journeys.last.fare
  end

  private

  def reset
    @past_journeys << @current_journey
    @current_journey = nil
  end

  def create_finished_journey(exit_station)
    @current_journey = Journey.new
  end
end
