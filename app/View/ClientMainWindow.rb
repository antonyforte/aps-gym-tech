require 'gtk3'
require_relative 'LoginWindow'

#Função da janela Principal de clientes
class ClientMainWindow < Gtk::Window

  #Função da Janela principal
  def initialize(id)
    super()
    set_title 'GymTech'
    set_default_size 200, 100

    @id = id

    #BOTÕES
    consult_avaliation_button = Gtk::Button.new(label: 'Consultar Avaliação')
    consult_avaliation_button.signal_connect('clicked') do
      show_avalations()
    end

    logout_button = Gtk::Button.new(label: 'Logout')
    logout_button.signal_connect('clicked') do
        logout
    end

    quit_button = Gtk::Button.new(label: 'Quit')
    quit_button.signal_connect('clicked') do
      Gtk.main_quit
    end

    #CAIXA COM OS COMPONENTES DA JANELA
    box = Gtk::Box.new(:vertical, 3)
    box.add(consult_avaliation_button)
    box.add(logout_button)
    box.add(quit_button)

    add(box)
  end

  def show_avalations()
    AvaliationListWindow.new(0,@id,0).show_all
    hide
  end


  #Função de logout
  def logout
    LoginWindow.new.show_all
    hide
  end

end
