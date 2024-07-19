require 'json'

require_relative '../Model/Avaliation'

require_relative '../Persist/AvaliationPersist'


class AvaliationController

  def register_avaliation(client_id, pt_id, height, weight, shoulder, chest, waist, tummy, hip, arm, forearm, thigh, calf)
    persist = AvaliationPersist.new
    persist.create(client_id, pt_id, height, weight, shoulder, chest, waist, tummy, hip, arm, forearm, thigh, calf)

  end

  def read_avaliation
    persist = AvaliationPersist.new
    persist.read(avaliation_id)
  end

  def delete_avaliation
    persist = AvaliationPersist.new
    persist.delete(avaliation_id)
  end

  def client_list_avaliation(client_id)
  end
end