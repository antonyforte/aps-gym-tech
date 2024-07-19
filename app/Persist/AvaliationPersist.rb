require 'date'
require 'json'
require 'securerandom'

require_relative '../Model/Avaliation'
require_relative '../Controller/AvaliationController'
require_relative '../Controller/ClientController'
require_relative '../Controller/PersonalTrainerController'

# Classe de persistência da entidade Avaliação
class AvaliationPersist

    # Cria uma avaliação 
    def create(client_id, pt_id, height, weight, shoulder, chest, waist, tummy, hip, arm, forearm, thigh, calf)
        
        # Cria um Controlador para Manipular os Clientes e Personal Trainers
        client_controller = ClientController.new
        pt_controller = PersonalTrainerController.new

        client =  client_controller.read_client(client_id)
        pt = pt_controller.read_pt(pt_id)

        # Recupera a Data atual para adicionar na avaliação
        date = DateTime.now
        date.strftime("%d/%m/%Y")
        workout_plan = "%"
        avaliation = Avaliation.new(client_id, pt_id, date, workout_plan, height, weight, shoulder, chest, waist, tummy, hip, arm, forearm, thigh, calf)


        # Gera um ID
        random_id = SecureRandom.uuid

        avaliation.id = random_id

        # Adiciona o ID da Avaliação nos dados do Cliente e Personal Trainer
        client_controller.add_avaliation(client_id, random_id)
        pt_controller.add_avaliation(pt_id, random_id)

        # Coloca os dados da Avaliação em formato JSON
        avaliation_json = {
            id: random_id,
            client_name: client.name,
            client_id: client_id,
            pt_name: pt.name,
            pt_id: pt_id,
            date: date,
            workout_plan: workout_plan,
            height: height,
            weight: weight,
            shoulder: shoulder,
            chest: chest,
            waist: waist,
            tummy: tummy,
            hip: hip,
            arm: arm, 
            forearm: forearm,
            thigh: thigh, 
            calf: calf
        }

        json_avaliation = JSON.pretty_generate(avaliation_json)

        File.open("database/avaliations/#{random_id}.json", 'w') do |file|
            file.write(json_avaliation)
        end

        puts "Avaliação criada com sucesso. ID: #{random_id}"
        return avaliation
    end

    def read(id)
        controller = AvaliationController.new
        file_path = "database/avaliations/#{id}.json"

        if File.exist?(file_path)
            avaliation_json = File.read(file_path)
            avaliation_data = JSON.parse(avaliation_json) 

            avaliation = Avaliation.new(avaliation_data['client_id'], avaliation_data['pt_id'], avaliation_data['date'], avaliation_data['height'], avaliation_data['weight'], avaliation_data['shoulder'], avaliation_data['chest'], avaliation_data['waist'], avaliation_data['tummy'], avaliation_data['hip'], avaliation_data['arm'], avaliation_data['forearm'], avaliation_data['thigh'], avaliation_data['calf'] )
            avaliation.id = avaliation_data['id']
        end
        return avaliation
    end

    # Deleta uma avaliação
    def delete(id)
        avaliation = read(id)
        avaliation_id = avaliation.id
        file_path = "database/avaliations/#{avaliation_id}.json"

        if File.exist?(file_path)
            File.delete(file_path)
            puts "Avaliação com ID #{id} deletado com sucesso."
            return true
        else
            puts "Avaliação com ID #{id} não encontrado."
            return false
        end
    end
end
