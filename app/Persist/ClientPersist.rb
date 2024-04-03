require 'json'
require 'securerandom'

require_relative '../Model/Client'
require_relative '../Controller/ClientController'

class ClientPersist < Persist
    controller = ClientController::new

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

        File.open("/home/antonioforte/Documentos/Faculdade/APS/Projeto/gymTech/database/clients/#{random_id}.json",'w') do |file|
            file.write(json_client)
        puts "Cliente criado com sucesso. Nome: #{name}, ID: #{random_id}"
        return client
        end
    end

    def read(name)
        clients_directory = "/home/antonioforte/Documentos/Faculdade/APS/Projeto/gymTech/database/clients"
        matching_clients = []
      
        Dir.glob("#{clients_directory}/*.json").each do |file_path|
          client_json = File.read(file_path)
          client_data = JSON.parse(client_json)
      
          if client_data['name'] == name
            client = Client.new(client_data['name'], client_data['age'], client_data['cell_number'])
            client.id = client_data['id']
            client_data['avaliation_ids'].each do |avaliation_id|
              controller.add_avaliation(client.id, avaliation_id)
            end
            matching_clients << client
          end
        end
      
        if matching_clients.empty?
          puts "Nenhum cliente encontrado com o nome '#{name}'"
        elsif matching_clients.length == 1
          return matching_clients.first
        else
          puts "Clientes encontrados com o nome '#{name}':"
          matching_clients.each_with_index do |client, index|
            puts "#{index + 1}: ID: #{client.id}, Idade: #{client.age}"
          end
          puts "Escolha um cliente pelo índice (1 - #{matching_clients.length}):"
          index = gets.chomp.to_i - 1
          if index >= 0 && index < matching_clients.length
            return matching_clients[index]
          else
            puts "Índice inválido"
          end
        end
      end
      


    def delete(id)

        file_path = "/home/antonioforte/Documentos/Faculdade/APS/Projeto/gymTech/database/clients/#{id}.json"

        if File.exist?(file_path)
        File.delete(file_path)
        puts "Cliente com ID #{id} deletado com sucesso."
        else
        puts "Cliente com ID #{id} não encontrado."
        end
    end
end