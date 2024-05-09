#Modelo da entidade Personal Trainer

class PersonalTrainer
    attr_accessor :id, :cpf, :name, :password,  :cell_number, :salary, :avaliations

    def initialize(cpf, name, password, cell_number, salary)
        @cpf = cpf
        @name = name
        @password = password
        @cell_number = cell_number
        @salary = salary
        @avaliations = []
    end

    
end