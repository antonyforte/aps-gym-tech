require_relative '../DAO'

require_relative '../Model/Client'
require_relative '../Model/PersonalTrainer'
require_relative '../Model/Avaliation'
require_relative '../Model/WorkoutPlan'
require_relative '../Model/Exercise'


#CONTROLLER REIMPLEMENTADO COM O PADRÃO STRATEGY
class Controller

  ## Instanciação dos Singletons do DAO
  def initialize
    @dao = DAO.instance
    @client_dao = ClientDAO.instance
    @personal_trainer_dao = PersonalTrainerDAO.instance
    @avaliation_dao = AvaliationDAO.instance
    @workout_plan_dao = WorkoutPlanDAO.instance
    @exercise_dao = ExerciseDAO.instance
  end

  ## STRATEGY DE REGISTRO
  class RegisterBehavior

    def register()
    end

  end

  class RegisterClient < RegisterBehavior
    def register(cpf,name,password,age,cell_number)
      client = Client.new(cpf,name,password,age,cell_number)
        @client_dao.create(client)
    end
  end

  class RegisterPersonalTrainer < RegisterBehavior
    def register(cpf,name,password,cell_number,salary)
      personal_trainer = PersonalTrainer.new(cpf,name,password,cell_number,salary)
      @personal_trainer_dao.create(personal_trainer)
    end
  end

  class RegisterAvaliation < RegisterBehavior
    def register(client_id, pt_id, height, weight, shoulder, chest, waist, tummy, hip, arm, forearm, thigh, calf)
      avaliation = Avaliation.new(client_id, pt_id,"","" height, weight, shoulder, chest, waist, tummy, hip, arm, forearm, thigh, calf)
      @avaliation_dao.create(avaliation)
    end
  end

  class RegisterWorkoutPlan < RegisterBehavior
    def register()
      workout_plan = WorkoutPlan.new
      @workout_plan_dao.create(workout_plan)
    end
  end

  class RegisterExercise < RegisterBehavior
    def register()
      exercise = Exercise.new
      @exercise_dao.create(exercise)
    end
  end

  ## STRATEGY DE LEITURA
  class ReadBehavior
    def read()
    end
  end

  class ReadClient < ReadBehavior
    def read(id)
      client = @client_dao.read(id)
      return client
    end
  end

  class ReadPersonalTrainer < ReadBehavior
    def read(id)
      personal_trainer = @personal_trainer_dao.read(id)
      return personal_trainer
    end
  end

  class ReadAvaliation < ReadBehavior
    def read(id)
      avaliation = @avaliation_dao.read(id)
      return avaliation
    end
  end

  class ReadWorkoutPlan < ReadBehavior
    def read(id)
      workout_plan = @workout_plan_dao.read(id)
      return workout_plan
    end
  end

  class ReadExercise < ReadBehavior
    def read(id)
      exercise = @exercise_dao.read(id)
      return exercise
    end
  end

  # STRATEGY DE EXCLUSÃO
  class DeleteBehavior
    def delete()
    end
  end

  class DeleteClient < DeleteBehavior
    def delete(id)
      return @client_dao.delete(id) == true
    end
  end

  class DeletePersonalTrainer < DeleteBehavior
    def delete(id)
      return @personal_trainer_dao.delete(id)
    end
  end

  class DeleteAvaliation < DeleteBehavior
    def delete(id)
      avaliation = ReadAvaliation.new.read(id)
      if avaliation.is_a?(Exercicio)
        DeleteAvaliationClient.new.delete_avaliation(avaliation.client,id)
        DeleteAvaliationPersonalTrainer.new.delete_avaliation(avaliation.personal_trainer,id)
        unless avaliation.workout_plan == ""
          DeleteWorkoutPlan.new.delete(avaliation.workout_plan)
        return @avaliation_dao.delete(id)
      else
        return false
      end 
    end
  end

  class DeleteWorkoutPlan < DeleteBehavior
    def delete(id)
      return @workout_plan_dao.delete(id)
    end
  end
  

  class DeleteExercise < DeleteBehavior
    def delete(id)
      return @exercise_dao.delete(id)
    end
  end

  # STRATEGY DE ADICIONAR UMA AVALIAÇÃO A UM USER
  class AddAvaliationBehavior
    def addAvaliation()
    end
  end

  class AddAvaliationClient < AddAvaliationBehavior
    def addAvaliation(client_id, avaliation_id)

      file_path = "database/clients/#{client_id}.json"
      client_json = JSON.parse(File.read(file_path))

       client_json["avaliation_ids"] << avaliation_id

      File.open(file_path, 'w') do |file|
          file.write(JSON.pretty_generate(client_json))

      end
    end
  end

  class AddAvaliationPersonalTrainer < AddAvaliationBehavior
    
    def add_avaliation(pt_id, avaliation_id)
      file_path = "database/pt/#{pt_id}.json"
      pt_json = JSON.parse(File.read(file_path))
      pt_json["avaliation_ids"] << avaliation_id
      File.open(file_path, 'w') do |file|
          file.write(JSON.pretty_generate(pt_json))
      end
    end

  end

  # STRATEGY DE APAGAR A AVALIAÇÃO DE UM USER
  class DeleteAvaliationBehavior
    def deleteAvaliation()
    end
  end

  class DeleteAvaliationClient < DeleteAvaliationBehavior
    
    def delete_avaliation(client_id, avaliation_id)
      file_path = "database/clients/#{client_id}.json"        
      if File.exist?(file_path)
        client_json = JSON.parse(File.read(file_path))
      
        if client_json["avaliation_ids"].include?(avaliation_id)
          client_json["avaliation_ids"].delete(avaliation_id)            
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
  end

  class DeleteAvaliationPersonalTrainer < DeleteAvaliationBehavior
    def delete_avaliation(pt_id, avaliation_id)
      file_path = "database/pt/#{pt_id}.json"
        
      if File.exist?(file_path)
        pt_json = JSON.parse(File.read(file_path))
        
        if pt_json["avaliation_ids"].include?(avaliation_id)
          pt_json["avaliation_ids"].delete(avaliation_id)
          
          File.open(file_path, 'w') do |file|
            file.write(JSON.pretty_generate(pt_json))
          end
    
          puts "Avaliação #{avaliation_id} removida com sucesso do Personal Trainer #{pt_id}."
        else
          puts "Avaliação #{avaliation_id} não encontrada para o Personal Trainer #{pt_id}."
        end
      else
        puts "Arquivo do Personal Trainer #{pt_id} não encontrado."
      end
    end
  end

  # STRATEGY QUE VERIFICA OS DADOS DE LOGIN E AUTENTICAÇÃO DO USER
  class LoginAuthVerifyBehavior
    def loginAuthenticationVerify()
    end
  end

  class LoginAuthVerifyBehaviorClient < LoginAuthVerifyBehavior
    
    def login_authentication_verify(name, id)
      client = @client_dao.read(id)
      if client == nil
        return false
      else
        return true
      end
    end

  end

  class LoginAuthVerifyBehaviorPersonalTrainer < LoginAuthVerifyBehavior
    
    def login_authentication_verify(name, id)
      personal_trainer = @personal_trainer_dao.read(id)
      if personal_trainer == nil
        return false
      else
        return true
      end
    end

  end

  # STRATEGY QUE RETORNA UMA LISTA DAS ENTIDADE
  class ListBehavior
    def list()
    end
  end

  class ListClient < ListBehavior
    
    def list()
      diretorio = "database/clients"
      files = Dir.glob(File.join(diretorio, "**","*"))
      id = []

      for file in files
          id_code = File.basename(file, ".*")
          id.push(id_code)
      end
      return id
    end

  end

  class ListPersonalTrainer < ListBehavior
    
    def list()
      diretorio = "database/pt"
      files = Dir.glob(File.join(diretorio, "**","*"))
      id = []
      for file in files
          id_code = File.basename(file, ".*")
          id.push(id_code)
      end
      return id
    end

    class ListAvaliationsClientPersonalTrainer < ListBehavior
      
      def list(client_id, pt_id)
        client = ReadClient.new.read(client_id)
        if (pt_id == 0)
          return client.avaliations
        else
          pt = ReadPersonalTrainer.new.read(pt_id)
          return client.avaliations & pt.avaliations
        end
      end

    end

    ## NÃO EXISTE LIST WORKOUTPLAN pois o cliente só pode ter acesso a sua ficha de treino pela avaliação, ou seja, utilizando o list avaliation

    class ListExercises < ListBehavior
      
      def list()
        diretorio = "database/exercise"
        files = Dir.glob(File.join(diretorio, "**","*"))
        id = []            
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


  end

  # STRATEGY PARA ADICIONAR UMA FICHA DE TREINO A UM OBJETO
  class AddWorkoutPlanBehavior

    def add_workout_plan()
    end

  end

  class AddWorkoutPlanAvaliation < AddWorkoutPlanBehavior
  
    def add_workout_plan(id, wp_id)
      file_path = "database/avaliations/#{id}.json"
      avaliation_json = JSON.parse(File.read(file_path))
      avaliation_json["workout_plan"] << wp_id
      File.open(file_path, 'w') do |file|
          file.write(JSON.pretty_generate(avaliation_json))
      end
    end
  end

end