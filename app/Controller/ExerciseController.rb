require 'json'

require_relative '../Model/Exercise'

require_relative '../Persist/ExercisePersist'



class ExerciseController

  def register_exercise(num,name,series,reps)
    persist = ExercisePersist.new
    persist.create(num,name,series,reps)

  end

  def read_exercise(id)

    persist = ExercisePersist.new
    return persist.read(id)
  end

  def delete_exercise(id)
    persist = ExercisePersist.new
    if persist.delete(id) == true
      return true
    else 
      return false
    end
  end

  def list_exercises()
    persist = ExercisePersist.new
    diretorio = "database/exercise"

    #Busca todos os arquivos dentro do banco de dados
    files = Dir.glob(File.join(diretorio, "**","*"))
    id = []
        
    #Salva em id, todos os ids
    for file in files
        id_code = File.basename(file, ".*")
        id.push(id_code)
    end
    exercises = []
    for i in ids
      exer = persist.read(i)
      exercises.push(exer)
    end

    return exercises
  end
end