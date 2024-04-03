class Exercise
    attr_accessor :num_aparelho, :name, :series, :reps
    
    def initialize(name, series, reps)
        @name = name
        @series = series
        @reps = reps
    end
end