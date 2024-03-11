class Endereco < ApplicationRecord
  belongs_to :municipe

  validates :cep, :logradouro, :bairro, :cidade, :uf, presence: true
  validates :cep, format: { with: /\A\d{5}-\d{3}\z/, message: 'formato inválido' }
  validates :municipe, presence: true
end
