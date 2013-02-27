class Location < ActiveRecord::Base

  class Region < Struct.new(:id, :name, :zip)
  end

  REGIONS = [
      Region.new(1, 'All', nil),
      Region.new(2, 'Hana', 96713),
      Region.new(3, 'Haiku', 96708),
      Region.new(4, 'Kihei', 96753),
      Region.new(5, 'Kahului', 96732),
      Region.new(6, 'Kaanapali', 96761),
      Region.new(7, 'Kaupo', 96790),
      Region.new(8, 'Wailuku', 96793),
      Region.new(9, 'Waiehu', 96793),
      Region.new(10, 'Waihee', 96793),
      Region.new(11, 'Napili', 96761),
      Region.new(12, 'Central', nil),
      Region.new(13, 'Wailea', 96753)
  ]

  attr_accessible :address,
                  :address2,
                  :state,
                  :zip,
                  :region_id,
                  :latitude,
                  :longitude

  has_many :resources

  validates :address, presence: true

  def region
    REGIONS.find { |rn| rn.id == region_id }
  end

  def label
    "#{address} #{region.try(:name)}"
  end

  def coords_set?
    latitude.present? && longitude.present?
  end

  class << self
    def coords
      [:latitude, :longitude]
    end
  end
end
