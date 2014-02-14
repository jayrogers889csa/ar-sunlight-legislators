require 'csv'
require_relative '../app/models/legislator'


module SunlightLegislatorsImporter
  FIELDS = [:title, :firstname, :lastname, :party, :state, :in_office, :gender, :phone, :fax, :website, :webform, :twitter_id, :birthdate]

  def self.import(filename)
    csv = CSV.new(File.open(filename), :headers => true, :header_converters => :symbol)
    csv.each do |row|
      Legislator.create!(filtered_attributes row)
      # require 'pry'; binding.pry
    end
  end

  def self.filtered_attributes(row)
    filtered_attributes = row.to_hash.keep_if { |field, _| FIELDS.include?(field) }
    filtered_attributes[:phone].gsub!(/\D/, "")
    filtered_attributes[:fax].gsub!(/\D/, "")
    filtered_attributes[:birthdate].gsub!(/\D/, "")
    filtered_attributes[:website].gsub!(/(http(s)?:\/\/)/, "")
    filtered_attributes[:webform].gsub!(/(http(s)?:\/\/)/, "")
    filtered_attributes
  end
end


SunlightLegislatorsImporter.import('db/data/legislators.csv')
