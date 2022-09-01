class Spottings
  def initialize
    @spottings = []
  end

  def self.from_array(spottings)
    instance = new
    spottings.each { |spotting| instance.add(spotting) }
    instance
  end

  def add(spotting)
    @spottings << spotting
  end

  def verify(radio_segment, column_index)
    @spottings.map { |spotting| spotting.verify(radio_segment, column_index) }
  end

  def cleanup!
    @spottings.reject!(&:invalid?)
  end

  def count
    @spottings.count
  end

  def complete
    @spottings.filter { |spotting| spotting.valid? && spotting.complete? }
  end

  def find_for(point_x, point_y)
    complete.find { |spotting| spotting.contains?(point_x, point_y) }
  end
end
