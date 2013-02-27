class Resource < ActiveRecord::Base
  attr_accessible :location_id, :name, :url

  attr_accessor :add_coordinates, :add_location

  belongs_to :location

  validates :name, presence: true
  validates :url, uniqueness: true, allow_blank: true

  before_validation :strip_protocol

  acts_as_ordered_taggable

  private

  def strip_protocol
    url.sub!(%r|\Ahttp://|, '') if url
  end
end
