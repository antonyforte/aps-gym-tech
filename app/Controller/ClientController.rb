require 'json'

require_relative '../Model/Client'

require_relative '../Persist/ClientPersist'


#Controlador da entidade Cliente
class ClientController

    #Função que registra um cliente, utilizando a Classe Persistência de Cliente
    def register_client(name,age,cell_number)
        
        persist = ClientPersist.new
        persist.create(name,age,cell_number)

    end

    #Função que deleta um cliente, utilizando a Classe Persistência de Cliente
    def delete_client(client_id)

        persist = ClientPersist.new
   
        if persist.delete(client_id) == true #Verifica se o id realmente existe
            return true
        else
            return false
        end
    end
    
    #Função que adiciona uma avaliação na lista de avaliações de um cliente
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

    #Função que verifica se as credenciais do cliente estão certas ##Utilizado pela view para fazer o login
    def login_authentication_verify(name,id)
        
        persist = ClientPersist.new
        client = persist.read(id)

        if client == nil #Verifica se o cliente existe no banco de dados
            return false
        else
            return true
        end
    end
end
