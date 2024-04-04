#Modelo da entidade Cliente

class Client
    attr_accessor :id, :name, :age, :cell_number, :avaliations

    def initialize(name, age, cell_number)
        @name = name
        @age = age
        @cell_number = cell_number
        @avaliations = []
    end
end