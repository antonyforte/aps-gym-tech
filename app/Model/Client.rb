#Modelo da entidade Cliente

class Client
    attr_accessor :id, :cpf, :name, :password, :age, :cell_number, :avaliations

    def initialize(cpf,name,password, age, cell_number)
        @cpf = cpf
        @name = name
        @password = password
        @age = age
        @cell_number = cell_number
        @avaliations = []
    end
end