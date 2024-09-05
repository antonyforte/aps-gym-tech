require 'json'

require_relative '../Model/WorkoutPlan'

require_relative '../Persist/WorkoutPlanPersist'

require_relative '../DAO'


#Controlador da entidade Cliente
class WorkoutPlanController

    def initialize
        @dao = WorkoutPlanDAO.instance
    end

    #Função que registra um cliente, utilizando a Classe Persistência de Cliente
    def register_wp()

        wp = WorkoutPlan.new
        @dao.create(wp)
    end

    def read(id)
      persist = WorkoutPlanPersist.new
      return persist.read(id)
    end

end