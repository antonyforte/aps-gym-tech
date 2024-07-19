require 'gtk3'
require_relative 'PersonalTrainerMainWindow'
require_relative '../Controller/AvaliationController'
require_relative '../Controller/ClientController'
require_relative '../Controller/PersonalTrainerController'



#Visão da janela Inicial do software
class AvaliationListWindow < Gtk::Window

  #Janela Principal, recebe o id do personal trainer, o id do cliente e um contador para saber qual avaliação esta sendo listada
  def initialize(id_pt,id, count)
    super()
    set_title 'GymTech'
    set_default_size 200, 100

    @count = count
    @id = id
    @id_pt = id_pt


    backward_button = Gtk::Button.new(label: 'Voltar')
    backward_button.signal_connect('clicked') do
        backward_window
    end 


    #Cria um widget TextView para exibir os nomes dos Personal Trainers
    @text_view = Gtk::TextView.new
    @text_view.editable = false
    @text_view.cursor_visible = false
    
    #Obtém a avaliação atual
    avaliation = list_avaliations(id,count)

    client_controller = ClientController.new
    pt_controller = PersonalTrainerController.new

    #Obtém o cliente e o personal trainer atual
    client =  client_controller.read_client(avaliation.client)
    pt = pt_controller.read_pt(avaliation.personal_trainer)

    #Constrói a primeira linha da tabela com os cabeçalhos
    table_text = "Cliente\tPersonal-Trainer\tData\n"

    table_text += "#{client.name}\t#{pt.name}\t#{avaliation.date}\n"

    #Adiciona os nomes ao TextView
    @text_view.buffer.text = table_text


    #BOTÕES
    meas_button = Gtk::Button.new(label: 'Consultar Medidas')
    meas_button.signal_connect('clicked') do
      show_measures(avaliation.id,id_pt,id,count)
    end

    workout_plan_button = Gtk::Button.new(label: 'Consultar Ficha de Treino')
    workout_plan_button.signal_connect('clicked') do
      ##FAZER
    end

    prev_button = Gtk::Button.new(label: 'Avaliação Anterior')
    prev_button.signal_connect('clicked') do
      previous_avaliation(id_pt,id, count)
    end
    backward_button = Gtk::Button.new(label: 'Voltar')
    backward_button.signal_connect('clicked') do
      backward_window
    end
    next_button = Gtk::Button.new(label: 'Próxima Avaliação')
    next_button.signal_connect('clicked') do
      next_avaliation(id_pt,id,count)
    end

    #CAIXA COM OS COMPONENTES DA JANELA

    box3 = Gtk::Box.new(:horizontal, 2)
    box3.add(meas_button)
    box3.add(workout_plan_button)

    box2 = Gtk::Box.new(:horizontal,3)
    box2.add(prev_button)
    box2.add(backward_button)
    box2.add(next_button)
    
    box = Gtk::Box.new(:vertical, 2)
    box.add(box3)
    box.add(@text_view)
    box.add(box2)


    add(box)
  end

  #Função que redireciona para a janela de login principal
  def backward_window
    if (@id_pt == 0)
      ClientMainWindow.new(@id).show_all
      hide
    else
      PersonalTrainerMainWindow.new(@id_pt).show_all
      hide
    end
  end

  # Mostra a Avaliação anterior a atual
  def previous_avaliation(pt_id, client_id, count)
    controller = AvaliationController.new
    limit = controller.client_list_avaliation(client_id)
    if(count - 1 == 0)
      new_count = limit.size - 1
      AvaliationListWindow.new(pt_id, client_id, new_count).show_all
      hide
    else
      AvaliationListWindow.new(pt_id, client_id,count-1).show_all
      hide
    end
  end


  # Mostra a proxima avaliação
  def next_avaliation(pt_id, client_id, count)
    controller = AvaliationController.new
    limit = controller.client_list_avaliation(client_id)
    if(count + 1 == limit.size)
      new_count = 0
      AvaliationListWindow.new(pt_id, client_id, new_count).show_all
      hide
    else
      AvaliationListWindow.new(pt_id, client_id,count+1).show_all
      hide
    end
  end

  # Mostra a janela de listagem de medidas
  def show_measures(avaliation_id,pt_id, client_id, count)
    AvaliationMeasuresListWindow.new(avaliation_id,pt_id, client_id, count).show_all
    hide
  end
  

  #Função que retorna a avaliação atual dada um contador
  def list_avaliations(client_id, count)
    controller = AvaliationController.new
    avaliation_ids = controller.client_list_avaliation(client_id)
    avaliation = show_avaliations(avaliation_ids[@count])
  end

  #Função que retorna a avaliação
  def show_avaliations(avaliation_id)
    controller = AvaliationController.new
    avaliation = controller.read_avaliation(avaliation_id)
    return avaliation
  end
end
