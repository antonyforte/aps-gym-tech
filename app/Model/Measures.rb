class Measures

    attr_accessor :id, :height, :weight,
    :shoulder, :chest, :waist, :tummy, :hip, :arm, :forearm, :thigh, :calf

    def initialize(height, weight, shoulder, chest, waist, tummy, hip, arm, forearm, thigh, calf)
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