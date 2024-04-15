require 'json'
require 'securerandom'

require_relative '../Model/Client'
require_relative '../Controller/ClientController'

#Classe de persistência para a entidade Cliente
class ClientPersist
    
    #Salva um cliente em formato json e salva em 'database/client/{id}.json'
    def create(name,age,cell_number)

        client = Client.new(name,age,cell_number)

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

        File.open("database/clients/#{random_id}.json",'w') do |file|
            file.write(json_client)
        puts "Cliente criado com sucesso. Nome: #{name}, ID: #{random_id}"
        return client
        end
    end

    #Procura um Cliente no banco de dados pelo seu ID; retorna o cliente se existir, retorna nil se nao existir
    def read(id)
      controller = ClientController.new
      file_path = "database/clients/#{id}.json"

      if File.exist?(file_path)
        client_json = File.read(file_path)
        client_data = JSON.parse(client_json) 
        
        client = Client.new(client_data['name'], client_data['age'], client_data['cell_number'])
        client.id = client_data['id']
        client_data['avaliation_ids'].each do |avaliation_id|
              controller.add_avaliation(client.id, avaliation_id)
        end
        return client
      else
        puts "Cliente com ID #{id} não encontrado."
        return nil
      end
    end

    # Deleta um cliente no banco de dados pelo seu id; retorna true se o cliente foi deletado com sucesso. retorna false se houver algum problema
    def delete(id)
        client = read(id)
        client_id = client.id
        file_path = "database/clients/#{client_id}.json"

        if File.exist?(file_path)
          File.delete(file_path)
          puts "Cliente com ID #{id} deletado com sucesso."
          return true
        else
          puts "Cliente com ID #{id} não encontrado."
          return false
        end
    end
end