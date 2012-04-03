class Room < ActiveRecord::Base
  has_many :bookings
  validates_presence_of :name, :param

  before_validation :derive_param, :on => :create

  delegate :booking_for, :to => :bookings

  def self.[](param)
    find_by_param(param) || find_by_id(param)
  end

  def to_param
    param
  end

  def to_s
    name
  end

private
  def derive_param
    self.param = name.gsub(/[^a-z-09 ]/i,'').parameterize
  end

end
