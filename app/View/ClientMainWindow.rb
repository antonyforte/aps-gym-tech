require 'gtk3'
require_relative 'LoginWindow'

#Função da janela Principal de clientes
class ClientMainWindow < Gtk::Window

  #Função da Janela principal
  def initialize
    super
    set_title 'GymTech'
    set_default_size 200, 100

    #BOTÕES
    consult_workout_plan_button = Gtk::Button.new(label: 'Consultar Ficha de Treino')
    consult_workout_plan_button.signal_connect('clicked') do
     #FUNCTION TO WINDOW X 
      #open_windowx
    end

    consult_measures_button = Gtk::Button.new(label: 'Consultar Medidas')
    consult_measures_button.signal_connect('clicked') do
        #FUNCTION TO WINDOWX
        #open_windowx
    end

    quit_button = Gtk::Button.new(label: 'Quit')
    quit_button.signal_connect('clicked') do
      Gtk.main_quit
    end

    #CAIXA COM OS COMPONENTES DA JANELA
    box = Gtk::Box.new(:vertical, 5)
    box.add(consult_workout_plan_button)
    box.add(consult_measures_button)
    box.add(quit_button)

    add(box)
  end

end
