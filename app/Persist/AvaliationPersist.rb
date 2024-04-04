
require 'json'
require 'securerandom'

require_relative '../Model/Avaliation'


# Classe de persistência da entidade Avaliação
class AvaliationPersist

    # Cria uma avaliação 
    def create(client_id, pt_id, date)

        avaliation = Avaliation.new(name,age,cell_number)

        random_id = SecureRandom.uuid

        client.id = random_id

        client_json = {
            id: random_id,
            name: name,
            age: age,
            cell_number: cell_number,
            avaliation_ids: []
            
        }

        json_client = JSON.pretty_generate(client_json)

        File.open("/home/antonioforte/Documentos/Faculdade/APS/Projeto/gymTech/database/clients/#{random_id}.json",'w') do |file|
            file.write(json_client)
        puts "Cliente criado com sucesso. Nome: #{name}, ID: #{random_id}"
        return client
        end

    end

    # Deleta uma avaliação
    def delete()
    end
end