#Modelo da entidade Exercicio

class Exercise
    attr_accessor :id, :num_aparelho, :name, :series, :reps
    
    def initialize(num, name, series, reps)
        @num_aparelho = num
        @name = name
        @series = series
        @reps = reps
    end
end