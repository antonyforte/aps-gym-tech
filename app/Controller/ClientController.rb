require 'json'

require_relative '../Model/Client'

require_relative '../Persist/ClientPersist'

require_relative '../DAO'


#Controlador da entidade Cliente
class ClientController

    def initialize
        @dao = ClientDAO.instance
    end

    #Função que registra um cliente, utilizando a Classe Persistência de Cliente
    def register_client(cpf,name,password,age,cell_number)

        client = Client.new(cpf,name,password,age,cell_number)
        @dao.create(client)
    end

    #Função que busca e retorna um cliente, Utilizando a classe Persistência de Cliente
    def read_client(client_id)
        persist = ClientPersist.new
        return persist.read(client_id)      
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
        file_path = "database/clients/#{client_id}.json"
        client_json = JSON.parse(File.read(file_path))

        #salvar na lista
        client_json["avaliation_ids"] << avaliation_id

        #alterar o arquivo com as modificações
        File.open(file_path, 'w') do |file|
            file.write(JSON.pretty_generate(client_json))
        end
    end


    # Função que deleta uma avaliação do JSON do cliente
    def delete_avaliation(client_id, avaliation_id)
        # Caminho para o arquivo JSON do cliente
        file_path = "database/clients/#{client_id}.json"
        
        # Ler o arquivo JSON do cliente
        if File.exist?(file_path)
          client_json = JSON.parse(File.read(file_path))
          
          # Remover o ID da avaliação da lista
          if client_json["avaliation_ids"].include?(avaliation_id)
            client_json["avaliation_ids"].delete(avaliation_id)
            
            # Salvar as modificações no arquivo JSON do cliente
            File.open(file_path, 'w') do |file|
              file.write(JSON.pretty_generate(client_json))
            end
      
            puts "Avaliação #{avaliation_id} removida com sucesso do cliente #{client_id}."
          else
            puts "Avaliação #{avaliation_id} não encontrada para o cliente #{client_id}."
          end
        else
          puts "Arquivo do cliente #{client_id} não encontrado."
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

    #Função que, utilizando a classe de Persistência retorna o id de todos os clientes cadastrados
    def list_client()
        persist = ClientPersist.new
        diretorio = "database/clients"

        #Busca todos os arquivos do banco de dados
        files = Dir.glob(File.join(diretorio, "**","*"))
        id = []

        #Salva os seus ids na lista id
        for file in files
            id_code = File.basename(file, ".*")
            id.push(id_code)
        end
        return id
    end
end
