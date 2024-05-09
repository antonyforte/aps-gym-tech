#Modelo da entidade Avaliação
class Avaliation
    attr_accessor :id, :client, :personal_trainer, :date, :workout_plan, :height, :weight,
    :shoulder, :chest, :waist, :tummy, :hip, :arm, :forearm, :thigh, :calf

    def initialize(client, personal_trainer, date, workout_plan,height, weight, shoulder, chest, waist, tummy, hip, arm, forearm, thigh, calf)
        @client = client
        @personal_trainer = personal_trainer
        @date = date
        @workout_plan = workout_plan
        @height = height
        @weight = weight
        @shoulder = shoulder
        @chest = chest
        @waist = waist
        @tummy = tummy
        @hip = hip
        @arm = arm
        @forearm = forearm
        @thigh = thigh
        @calf = calf
    end
end