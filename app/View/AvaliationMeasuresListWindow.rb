require 'gtk3'
require_relative 'PersonalTrainerMainWindow'
require_relative '../Controller/AvaliationController'
require_relative '../Controller/ClientController'
require_relative '../Controller/PersonalTrainerController'



#Visão da janela Inicial do software
class AvaliationMeasuresListWindow < Gtk::Window

  #Janela Principal, recebe os ids's respectivamente de: avaliações, personal trainer e cliente. Assim como também o contador atual
  def initialize(avaliation_id,id_pt,id, count)
    super()
    set_title 'GymTech'
    set_default_size 200, 100

    @id = id
    @id_pt = id_pt
    avaliation = get_avaliation(avaliation_id)

    #Cria um widget TextView para exibir as medidas
    @text_view = Gtk::TextView.new
    @text_view.editable = false
    @text_view.cursor_visible = false
    
    table_text = "Altura: #{avaliation.height}\n
    Peso: #{avaliation.weight}\n
    Ombro: #{avaliation.shoulder}\n
    Peito: #{avaliation.chest}\n
    Cintura: #{avaliation.waist}\n 
    Abdomem: #{avaliation.tummy}\n 
    Quadril: #{avaliation.hip}\n 
    Braço: #{avaliation.arm}\n 
    Ante-Braço: #{avaliation.forearm}\n 
    Coxa: #{avaliation.thigh}\n 
    Panturrilha: #{avaliation.calf}\n
    "

    #BOTÕES
    backward_button = Gtk::Button.new(label: 'Voltar')
    backward_button.signal_connect('clicked') do
      backward_window
    end
    #Adiciona os nomes ao TextView
    @text_view.buffer.text = table_text

    #CAIXA COM OS COMPONENTES
    box = Gtk::Box.new(:vertical, 1)
    box.add(backward_button)

    box2 = Gtk::Box.new(:horizontal,1)
    box2.add(@text_view)
    box2.add(box)

 

    add(box2)
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

  #Função que retorna a avaliação dada um ID
  def get_avaliation(avaliation_id)
    controller = AvaliationController.new
    return controller.read_avaliation(avaliation_id)
  end
end
