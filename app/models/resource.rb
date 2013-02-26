class Resource < ActiveRecord::Base
  attr_accessible :location_id, :name, :url

  attr_accessor :use_coordinates

  belongs_to :location

  validates :name, presence: true

  acts_as_ordered_taggable
end
