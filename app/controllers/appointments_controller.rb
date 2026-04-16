class AppointmentsController < ApplicationController
  def index
    @appointments = Appointment.includes(:pet, :vet).all
  end

  def show
    @appointment = Appointment.includes(:treatments, :pet, :vet).find(params[:id])
  end
end