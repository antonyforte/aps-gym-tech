#Modelo da entidade Avaliação
class Avaliation
    attr_accessor :id, :client, :personal_trainer, :date, :workout_plan

    def initialize(client, personal_trainer, date, workout_plan, measures)
        @client = client
        @personal_trainer = personal_trainer
        @date = date
        @workout_plan = workout_plan
        @measures = measures
    end
end