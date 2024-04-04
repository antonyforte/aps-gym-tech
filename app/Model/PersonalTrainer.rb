#Modelo da entidade Personal Trainer

class PersonalTrainer
    attr_accessor :id, :name, :cell_number, :salary, :avaliations

    def initialize(name, cell_number, salary)
        @name = name
        @cell_number = cell_number
        @salary = salary
        @avaliations = []
    end

    
end