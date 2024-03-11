class CreateEnderecos < ActiveRecord::Migration[7.1]
  def change
    create_table :enderecos do |t|
      t.references :municipe, null: false, foreign_key: true
      t.string :cep
      t.string :logradouro
      t.string :complemento
      t.string :bairro
      t.string :cidade
      t.string :uf
      t.string :codigo_ibge

      t.timestamps
    end
  end
end
