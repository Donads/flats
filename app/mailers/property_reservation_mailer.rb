class PropertyReservationMailer < ApplicationMailer
  def notify_new_reservation
    @reservation = params[:reservation]
    @property = @reservation.property

    mail(to: @property.property_owner.email, subject: "Nova reserva para seu imóvel #{@property.title}")
  end
end
