require 'json'

require_relative '../Model/PersonalTrainer'

require_relative '../Persist/PersonalTrainerPersist'

#Controlador da entidade Personal Trainer
class PersonalTrainerController
    
    #Função que registra um personal trainer
    def register_pt(name,cell_number,salary)
        persist = PersonalTrainerPersist.new
        persist.create(name,cell_number,salary)
    end

    #Função que deleta um personal trainer
    def delete_pt(pt_id)
        persist = PersonalTrainerPersist.new
        if persist.delete(pt_id) == true #Verifica se o Personal Trainer existe no banco de dados
            return true
        else
            return false
        end
    end

    #Função que adiciona uma avaliação na lista de avaliações do Personal Trainer
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

    #Função que verifica as credenciais do personal trainer. ##Utilizado na view de login
    def login_authentication_verify(name,id)
        
        persist = PersonalTrainerPersist.new
        pt = persist.read(id)

        if pt == nil #verifica se as credenciais batem
            return false
        else
            return true
        end
    end
end
