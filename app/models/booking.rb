class Booking < ActiveRecord::Base
  class DateCollisionValidator < ActiveModel::Validator
    def validate(booking)
      if not_in_the_past(booking)
        not_overlapping(booking)
      else
        booking.errors[:date] << "is in the past?"
      end
    end

    def not_in_the_past(booking)
      Date.today <= booking.date && Time.now < booking.from
    end

    def not_overlapping(booking)
      from = Booking.arel_table[:from]
      to = Booking.arel_table[:to]
      range = booking.from..booking.to
      Booking.where(:date => booking.date).where(to.in(range).or(from.in(range))).empty?
    end
  end

  belongs_to :room
  # validates_with DateCollisionValidator
  validates_presence_of :room

  def self.booking_for(time)
    from = arel_table[:from]
    to = arel_table[:to]
    self.for(time.to_date).where(from.lteq(time).and(to.gt(time))).first
  end

  def self.for(day)
    where(:date => day)
  end

  def blocks
    ((to - from)/60/15).to_i
  end
end
