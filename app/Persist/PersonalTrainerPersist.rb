require 'json'
require 'securerandom'

require_relative '../Model/PersonalTrainer'
require_relative '../Controller/PersonalTrainerController'

# Classe de persistência da entidade Personal Trainer 
class PersonalTrainerPersist

    # Função que adiciona um Peronal no banco de dados
    def create(cpf, name, password, cell_number, salary)
        

        personal_trainer = PersonalTrainer::new(cpf,name,password,cell_number,salary)

        random_id = "su"+SecureRandom.uuid

        personal_trainer.id = random_id

        pt_json = {
            id: random_id,
            cpf: cpf,
            name: name,
            password: password,
            cell_number: cell_number,
            salary: salary,
            avaliation_ids: []
        }

        json_pt = JSON.pretty_generate(pt_json)

        File.open("database/pt/#{random_id}.json",'w') do |file|
            file.write(json_pt)
        puts "Personal Trainer criado com sucesso. Nome: #{name}, ID: #{random_id}"
        return personal_trainer
        end
    end

    # Função que procura um Personal Trainer no banco de dados pelo seu id; Retorna o Personal Trainer se existir, retorna nil se nao houver
    def read(id)
      controller = PersonalTrainerController.new

      file_path = "database/pt/#{id}.json"

      if File.exist?(file_path)
        pt_json = File.read(file_path)
        pt_data = JSON.parse(pt_json) 
        
        pt = PersonalTrainer.new(pt_data['cpf'], pt_data['name'], pt_data['password'], pt_data['salary'], pt_data['cell_number'])
        pt.id = pt_data['id']
        pt_data['avaliation_ids'].each do |avaliation_id|
              pt.avaliations << avaliation_id
        end
        return pt
      else
        puts "Personal Trainer com ID #{id} não encontrado."
        return nil
      end
    end
      

    # Função que deleta um personal trainer pelo seu id; retorna true se for deletado com sucesso, retorna false se houver algum problema 
    def delete(id)
        pt = read(id)
        pt_id = pt.id
        file_path = "database/pt/#{pt_id}.json"

        if File.exist?(file_path)
          File.delete(file_path)
          puts "Personal Trainer com ID #{id} deletado com sucesso."
          return true
        else
          puts "Personal Trainer com ID #{id} não encontrado."
          return false
        end
    end

end