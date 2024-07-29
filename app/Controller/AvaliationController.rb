require 'json'

require_relative '../Model/Avaliation'

require_relative '../Persist/AvaliationPersist'

require_relative '../Controller/ClientController'

require_relative '../Controller/PersonalTrainerController'



class AvaliationController

  # Usando a Persistencia, registra uma avaliação
  def register_avaliation(client_id, pt_id, height, weight, shoulder, chest, waist, tummy, hip, arm, forearm, thigh, calf)
    persist = AvaliationPersist.new
    persist.create(client_id, pt_id, height, weight, shoulder, chest, waist, tummy, hip, arm, forearm, thigh, calf)

  end

  # Retorna uma Avaliação dado um id
  def read_avaliation(avaliation_id)
    persist = AvaliationPersist.new
    persist.read(avaliation_id)
  end

  # Deleta uma avaliação e também as deleta de dentro dos JSON dos clientes e personal trainers
  def delete_avaliation(avaliation_id)
    client_controller = ClientController.new
    pt_controller = PersonalTrainerController.new
    avaliation = read_avaliation(avaliation_id)

    client_controller.delete_avaliation(avaliation.client, avaliation_id)
    pt_controller.delete_avaliation(avaliation.personal_trainer, avaliation_id)

    persist = AvaliationPersist.new
    persist.delete(avaliation_id)
  end


  # Dado um cliente e um pt retorna os ids das avaliações desse cliente
  def client_list_avaliation(client_id, pt_id)
    
    client_Controller = ClientController.new
    pt_controller = PersonalTrainerController.new
    client = client_Controller.read_client(client_id)
    if (pt_id == 0)
      return client.avaliations
    else
      pt = pt_controller.read_pt(pt_id)
      return client.avaliations & pt.avaliations
    end
  end
end