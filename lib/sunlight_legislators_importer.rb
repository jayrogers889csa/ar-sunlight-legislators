require 'csv'
require_relative '../app/models/legislator'


module SunlightLegislatorsImporter
  FIELDS = [:title, :firstname, :lastname, :party, :state, :in_office, :gender, :phone, :fax, :website, :webform, :twitter_id, :birthdate]

  def self.import(filename)
    csv = CSV.new(File.open(filename), :headers => true, :header_converters => :symbol)
    require 'pry'; binding.pry
    csv.each do |row|
      Legislator.create!(filtered_attributes row)
    end
  end

  def self.filtered_attributes(row)
    row.to_hash.keep_if { |field, _| FIELDS.include?(field) }
  end
end


SunlightLegislatorsImporter.import('db/data/legislators.csv')
