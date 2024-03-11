class Municipe < ApplicationRecord
  has_one :endereco, dependent: :destroy
  accepts_nested_attributes_for :endereco

  validates :nome_completo, :cpf, :cns, :email, :data_nascimento, :telefone, :foto, presence: true
  validates :cpf, uniqueness: true
  validates :cpf, format: { with: /\A\d{3}\.\d{3}\.\d{3}-\d{2}\z/, message: 'formato inválido' }
  validates :cns, format: { with: /\A\d{15}\z/, message: 'formato inválido' }
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: 'formato inválido' }
  validate :data_nascimento_valida

  after_create :enviar_email_e_sms_cadastro
  after_update :enviar_email_e_sms_atualizacao_status

  def data_nascimento_valida
    return unless data_nascimento.present? && data_nascimento > Date.today

    errors.add(:data_nascimento, 'não pode estar no futuro')
  end

  def enviar_email_e_sms_cadastro
    # UserMailer.welcome_email(@municipe, 'Welcome', @municipe.to_json).deliver_now
    # sendpulse = SendpulseService.new(SENDPULSE_API_USER, SENDPULSE_API_KEY)
    # sendpulse.send_sms(telefone, 'Atualização no cadastro do cadastro de Municipe')
  end

  def enviar_email_e_sms_atualizacao_status
    # UserMailer.update_email(@municipe, 'Update', @municipe.to_json).deliver_now
    # sendpulse = SendpulseService.new(SENDPULSE_API_USER, SENDPULSE_API_KEY)
    # sendpulse.send_sms(telefone, 'Atualização no cadastro do cadastro de Municipe')
  end
end
