class PropertyReservationMailerPreview < ActionMailer::Preview
  def notify_new_reservation
    reservation = create(:property_reservation)

    PropertyReservationMailer.with(reservation: reservation).notify_new_reservation
  end
end
