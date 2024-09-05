require 'json'
require 'securerandom'

require_relative '../Model/Exercise'
require_relative '../Controller/ExerciseController'

class ExercisePersist

  def create(num_aparelho, name, series, reps)

    exercise = Exercise.new(num_aparelho, name, series, reps)
    random_id = SecureRandom.uuid

    exercise.id = random_id

    exercise_json = {
        id: random_id,
        num_aparelho: num_aparelho,
        name: name,
        series: series,
        reps: reps
    }

    json_exercise = JSON.pretty_generate(exercise_json)

    File.open("database/exercises/#{random_id}.json",'w') do |file|
        file.write(json_exercise)
    puts "Exercício adicionado com sucesso. Nome: #{name}, ID: #{random_id}"
    return exercise
    end
  end

  def read(id)
      file_path = "database/exercises/#{id}.json"

      if File.exist?(file_path)
        exercise_json = File.read(file_path)
        exercise_data = JSON.parse(exercise_json) 
        
        exercise = Exercise.new(exercise_data['num_aparelho'], exercise_data['name'], exercise_data['series'], exercise_data['reps'])
        exercise.id = exercise_data['id']
        return exercise
      else
        puts "Exercício com ID #{id} não encontrado."
        return nil
      end
  end

  def delete(id)
    exercise = read(id)
    exercise_id = exercise.id
    file_path = "database/exercises/#{exercise_id}.json"

    if File.exist?(file_path)
      File.delete(file_path)
      puts "Exercício com ID #{id} deletado com sucesso."
      return true
    else
      puts "Exercício com ID #{id} não encontrado."
      return false
    end
  end

end