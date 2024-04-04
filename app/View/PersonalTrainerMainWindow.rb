require 'gtk3'
require_relative 'LoginWindow'
require_relative 'ClientDeleteWindow'
require_relative 'ClientRegisterWindow'

#Visão da Janela principal de Peronal Trainer
class PersonalTrainerMainWindow < Gtk::Window
  #Janela principal
  def initialize
    super
    set_title 'GymTech'
    set_default_size 200, 100

    #BOTÕES
    register_client_button = Gtk::Button.new(label: 'Registrar Cliente')
    register_client_button.signal_connect('clicked') do
     register_client_window
    end

    register_avaliation_button = Gtk::Button.new(label: 'Fazer Avaliação')
    register_avaliation_button.signal_connect('clicked') do
        #FUNCTION TO WINDOW X
        #open_windowx
    end

    delete_client_button = Gtk::Button.new(label: 'Deletar Cliente')
    delete_client_button.signal_connect('clicked') do
        delete_client_window
    end
    quit_button = Gtk::Button.new(label: 'Quit')
    quit_button.signal_connect('clicked') do
      Gtk.main_quit
    end

    #CAIXA COM OS COMPONENTES DA JANELA
    box = Gtk::Box.new(:vertical, 5)
    box.add(register_client_button)
    box.add(register_avaliation_button)
    box.add(delete_client_button)
    box.add(quit_button)

    add(box)
  end

  #FUNÇÃO QUE ABRE A JANELA DE REGISTRO DE CLIENTES
  def register_client_window
    ClientRegisterWindow.new.show_all
    hide
  end

  #FUNÇÃO QUE ABRE A JANELA DE EXCLUSÃO DE CLIENTES
  def delete_client_window
    ClientDeleteWindow.new.show_all
    hide
  end

end
