class PropertyReservation < ApplicationRecord
  enum status: { pending: 10, accepted: 20, rejected: 30 }

  belongs_to :property
  belongs_to :user

  before_save :calculate_total_value
  before_create :generate_code

  validates :code, uniqueness: true

  validate :end_date_greater_than_start_date
  validate :start_date_cannot_be_in_the_past
  # TODO: Criar validação pra não permitir reserva em período onde já houver outra reserva aprovada

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
    generate_code if PropertyReservation.exists?(code: code)
  end

  def calculate_total_value
    self.total_value = (end_date - start_date).to_i * property.daily_rate
  end

  def end_date_greater_than_start_date
    errors.add(:end_date, I18n.t('errors.messages.end_date_greater_than_start_date')) if end_date <= start_date
  end

  def start_date_cannot_be_in_the_past
    errors.add(:start_date, 'não pode estar no passado') if start_date < Date.today
  end
end
