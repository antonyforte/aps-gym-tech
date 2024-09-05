require 'singleton'

require_relative 'Model/Client'
require_relative 'Model/PersonalTrainer'
require_relative 'Model/Avaliation'
require_relative 'Model/WorkoutPlan'

require_relative 'Persist/ClientPersist'
require_relative 'Persist/PersonalTrainerPersist'
require_relative 'Persist/AvaliationPersist'
require_relative 'Persist/WorkoutPlanPersist'

require_relative 'Controller/ClientController'
require_relative 'Controller/PersonalTrainerController'
require_relative 'Controller/AvaliationController'
require_relative 'Controller/WorkoutPlanController'



class DAO
  include Singleton

  def initialize
    puts "DAO Inicializado"
  end
  def create(obj)
    raise NotImplementedError , "Tipo do Objeto Não identificado"
  end

  def read(id)
    raise NotImplementedError , "Tipo do Objeto Não identificado"
  end

  def delete(id)
    raise NotImplementedError , "Tipo do Objeto Não identificado"
  end
end

class ClientDAO < DAO
  include Singleton

  def create(obj)
    persist = ClientPersist.new
    persist.create(obj.cpf,obj.name,obj.password,obj.age,obj.cell_number)
  end

  def read(id)
    persist = ClientPersist.new
    return persist.read(id)
  end

  def delete(id)
    persist = ClientPersist.new
    if persist.delete(id) == true #Verifica se o id realmente existe
        return true
    else
        return false
    end
  end
end

class PersonalTrainerDAO < DAO
  include Singleton
  def create(obj)
    persist = PersonalTrainerPersist.new
    persist.create(obj.cpf,obj.name,obj.password,obj.cell_number,obj.salary)
  end

  def read(id)
    persist = PersonalTrainerPersist.new
    return persist.read(id)  
  end

  def delete(id)
    persist = ClientPersist.new
    if persist.delete(id) == true #Verifica se o id realmente existe
        return true
    else
        return false
    end
  end
end

class AvaliationDAO < DAO
  include Singleton

  def create(obj)
    persist = AvaliationPersist.new
    persist.create(obj.client_id, obj.pt_id, obj.height, obj.weight, obj.shoulder, obj.chest, obj.waist, obj.tummy, obj.hip, obj.arm, obj.forearm, obj.thigh, obj.calf)
  end
  
  def read(id)
    persist = AvaliationPersist.new
    persist.read(id)
  end

  def delete(id)
    client_controller = ClientController.new
    pt_controller = PersonalTrainerController.new
    avaliation = read_avaliation(id)

    client_controller.delete_avaliation(avaliation.client, id)
    pt_controller.delete_avaliation(avaliation.personal_trainer, id)

    persist = AvaliationPersist.new
    persist.delete(id)
  end
end

class WorkoutPlanDAO < DAO
  include Singleton

  def create(obj)
    persist = WorkoutPlanPersist.new
    persist.create()
  end
  
  def read(id)
    persist = WorkoutPlanPersist.new
    persist.read(id)
  end

  def delete(id)
    persist = WorkoutPlanPersist.new
    persist.delete(id)
  end

  class ExerciseDAO < DAO 
    def create(obj)
      persist = ExercisePersist.new
      persist.create(obj.num_aparelho, obj.name, obj.series, obj.reps)
    end
    
    def read(id)
      persist = ExercisePersist.new
      persist.read(id)
    end
  
    def delete(id)
      persist = ExercisePersist.new
      persist.delete(id)
  end
end