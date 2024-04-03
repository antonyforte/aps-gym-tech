require 'json'

require_relative '../Model/PersonalTrainer'

class PersonalTrainerController
    
    
    def add_avaliation(pt_id, avaliation_id)
        #abrir o arquivo do cliente com o id tal
        file_path = "/home/antonioforte/Documentos/Faculdade/APS/Projeto/gymTech/database/pt/#{pt_id}.json"
        pt_json = JSON.parse(File.read(file_path))

        #salvar na lista
        pt_json["avaliation_ids"] << avaliation_id

        #alterar o arquivo com as modificações
        File.open(file_path, 'w') do |file|
            file.write(JSON.pretty_generate(pt_json))
        end
    end
end
