class BookingsController < ApplicationController
  def new
    @booking = Booking.new(flight_id: params[:flight_id], num_tickets: params[:num_tickets])
    @booking.num_tickets.times { @booking.passengers.build }
  end

  def index
    # Set num_tickets to a default value if it's not provided in params
    num_tickets = params[:num_tickets].presence || 1

    # Create a new Booking object with the specified num_tickets
    @booking = Booking.new(flight_id: params[:flight_id], num_tickets: num_tickets.to_i)

    # Build passengers for the booking based on the number of tickets
    @booking.num_tickets.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params)
    respond_to do |format|
      if @booking.save
        format.html { redirect_to booking_url(@booking), notice: "Your flight is booked!" }
      else
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  private

  def booking_params
    params.require(:booking).permit(:flight_id, :num_tickets, passengers_attributes:[:name,:email,:booking_id])
  end
end
