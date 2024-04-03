require 'json'
require 'securerandom'

require_relative '../Model/PersonalTrainer'
require_relative '../Controller/PersonalTrainerController'
class PersonalTrainerPersist < Persist

    def create(name, cell_number, salary)
        
        controller = PersonalTrainerController::new

        personal_trainer = PersonalTrainer::new(name,cell_number,salary)

        random_id = SecureRandom.uuid

        personal_trainer.id = random_id

        pt_json = {
            id: random_id,
            name: name,
            cell_number: cell_number,
            salary: salary,
            avaliation_ids: []
        }

        json_pt = JSON.pretty_generate(pt_json)

        File.open("/home/antonioforte/Documentos/Faculdade/APS/Projeto/gymTech/database/pt/#{random_id}.json",'w') do |file|
            file.write(json_pt)
        puts "Personal Trainer criado com sucesso. Nome: #{name}, ID: #{random_id}"
        return personal_trainer
        end
    end

    def read(name)
        pt_directory = "/home/antonioforte/Documentos/Faculdade/APS/Projeto/gymTech/database/pt"
        matching_pts = []
      
        Dir.glob("#{pt_directory}/*.json").each do |file_path|
          pt_json = File.read(file_path)
          pt_data = JSON.parse(pt_json)
      
          if pt_data['name'] == name
            pt = PersonalTrainer.new(pt_data['name'], pt_data['cell_number'], pt_data['salary'])
            pt.id = pt_data['id']
            pt_data['avaliation_ids'].each do |avaliation_id|
              controller.add_avaliation(pt.id, avaliation_id)
            end
            matching_pts << pt
          end
        end
      
        if matching_pts.empty?
          puts "Nenhum personal trainer encontrado com o nome '#{name}'"
        elsif matching_pts.length == 1
          return matching_pts.first
        else
          puts "Personal trainers encontrados com o nome '#{name}':"
          matching_pts.each_with_index do |pt, index|
            puts "#{index + 1}: ID: #{pt.id}, Salário: #{pt.salary}"
          end
          puts "Escolha um personal trainer pelo índice (1 - #{matching_pts.length}):"
          index = gets.chomp.to_i - 1
          if index >= 0 && index < matching_pts.length
            return matching_pts[index]
          else
            puts "Índice inválido"
          end
        end
      end
      

    def delete(id)
        
        file_path = "/home/antonioforte/Documentos/Faculdade/APS/Projeto/gymTech/database/pt/#{id}.json"

        if File.exist?(file_path)
        File.delete(file_path)
        puts "Personal Trainer com ID #{id} deletado com sucesso."
        else
        puts "Personal Trainer com ID #{id} não encontrado."
        end
    end

end