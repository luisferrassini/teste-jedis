json.extract! @endereco, :id, :cep, :logradouro, :complemento, :bairro, :cidade, :uf, :codigo_ibge

json.url endereco_url(endereco, format: :json)
