class RoomsController < ApplicationController
  helper_method :rooms, :room, :day, :timespan

  def index
  end

  def show
  end

  def today
    @day = Date.today
  end

protected
  def rooms
    Room.all
  end

  def room
    @room ||= Room[params[:id]] or raise ActiveRecord::RecordNotFound
  end

  def day
    @day
  end

  def timespan(hour, minute)
    Time.parse("%d:%02d" % [hour,minute], day)
  end
end
