#Modelo da entidade Ficha de Treino

class WorkoutPlan 

    attr_accessor :id, :monday_exercises, :tuesday_exercises, :wednesday_exercises, :thursday_exercises, :friday_exercises, :saturday_exercises, :sunday_exercises

    def initialize()
        @monday_exercises = []
        @tuesday_exercises = []
        @wednesday_exercises = []
        @thursday_exercises = []
        @saturday_exercises = []
        @sunday_exercises = []
    end
end