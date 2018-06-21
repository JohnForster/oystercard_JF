require 'csv'

class CSVParser
  def self.parse_csv(csv)
    CSV.read(csv).map { |row| [row[0].downcase, row[5]] }.to_h
  end
end
