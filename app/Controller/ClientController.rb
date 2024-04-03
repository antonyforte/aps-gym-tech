require 'json'

require_relative '../Model/Client'

class ClientController
    
    def add_avaliation(client_id, avaliation_id)
        #abrir o arquivo do cliente com o id tal
        file_path = "/home/antonioforte/Documentos/Faculdade/APS/Projeto/gymTech/database/clients/#{client_id}.json"
        client_json = JSON.parse(File.read(file_path))

        #salvar na lista
        client_json["avaliation_ids"] << avaliation_id

        #alterar o arquivo com as modificações
        File.open(file_path, 'w') do |file|
            file.write(JSON.pretty_generate(client_json))
        end
    end
end
