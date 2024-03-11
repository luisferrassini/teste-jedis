json.extract! @municipe, :id, :nome_completo, :cpf, :cns, :email, :data_nascimento, :telefone, :foto, :status
json.endereco do
  json.extract! @municipe.endereco, :cep, :logradouro, :complemento, :bairro, :cidade, :uf, :codigo_ibge
end
json.url municipe_url(municipe, format: :json)
