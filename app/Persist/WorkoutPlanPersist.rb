require 'date'
require 'json'
require 'securerandom'

require_relative '../Model/WorkoutPlan'
require_relative '../Controller/WorkoutPlanController'
require_relative '../Controller/ExerciseController'

class WorkoutPlanPersist

    def create()

        wp = WorkoutPlan.new()
        random_id = SecureRandom.uuid

        wp.id = random_id

        wp_json = {
            id: random_id,
            monday_exercises: [],
            tuesday_exercises: [],
            wednesday_exercises: [],
            thursday_exercises: [],
            friday_exercises: [],
            saturday_exercises: [],
            sunday_exercises: []
        }

        json_wp = JSON.pretty_generate(wp_json)
        File.open("database/wp/#{random_id}.json", 'w') do |file|
            file.write(json_wp)
        end
        
        puts "Ficha de Treino criada com sucesso."
        return wp
    end

    def read(id)
        puts "#{id}"
        file_path = "database/wp/#{id}.json"

        if File.exist?(file_path) 
            wp_json = File.read(file_path)
            wp_data = JSON.parse(wp_json)

            wp = WorkoutPlan.new()
            wp.monday_exercises = wp_data['monday_exercises']
            wp.tuesday_exercises = wp_data['tuesday_exercises']
            wp.wednesday_exercises = wp_data['wednesday_exercises']
            wp.thursday_exercises = wp_data['thursday_exercises']
            wp.friday_exercises = wp_data['friday_exercises']
            wp.saturday_exercises = wp_data['saturday_exercises']
            wp.sunday_exercises = wp_data['sunday_exercises']

            wp.id = wp_data['id']
            return wp
        end
    end

    def delete(id)
        wp = read(id)
        wp_id = wp.id
        file_path = "database/wp/#{wp_id}.json"

        if File.exist?(file_path)  
            File.delete(file_path)
            puts "Ficha de Treino com ID #{id} deletado com sucesso."
            return true
        else
            puts "Ficha de Treino com ID #{id} não encontrado."
            return false
        end
    end

end