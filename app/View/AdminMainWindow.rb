require 'gtk3'
require_relative 'LoginWindow'
require_relative 'PersonalTrainerDeleteWindow'
require_relative 'PersonalTrainerRegisterWindow'

# Visão da janela de administrador ##Janela onde gerencia o crud dos Personal Trainer's
class AdminMainWindow < Gtk::Window
  
  #Função da janela principal
  def initialize
    super
    set_title 'GymTech'
    set_default_size 200, 100

    #BOTÕES
    register_pt_button = Gtk::Button.new(label: 'Registrar Personal Trainer')
    register_pt_button.signal_connect('clicked') do
     register_pt_window
    end

    list_pt_button = Gtk::Button.new(label: 'Listar Personal Trainer')
    list_pt_button.signal_connect('clicked') do
        list_pt_window
    end

    delete_pt_button = Gtk::Button.new(label: 'Deletar Personal Trainer')
    delete_pt_button.signal_connect('clicked') do
        delete_pt_window
    end
    
    logout_button = Gtk::Button.new(label: 'Logout')
    logout_button.signal_connect('clicked') do
        logout
    end

    quit_button = Gtk::Button.new(label: 'Quit')
    quit_button.signal_connect('clicked') do
      Gtk.main_quit
    end

    #Caixa com os componentes da janela
    box = Gtk::Box.new(:vertical, 5)
    box.add(register_pt_button)
    box.add(list_pt_button)
    box.add(delete_pt_button)
    box.add(logout_button)
    box.add(quit_button)

    add(box)
  end

  #Função que redireciona para a janela de registro de Personal Trainer
  def register_pt_window
    PersonalTrainerRegisterWindow.new.show_all
    hide
  end

  #Função que redireciona para a janela de exclusão de Personal Trainer
  def delete_pt_window
    PersonalTrainerDeleteWindow.new.show_all
    hide
  end

  #Função que redireciona para a janela com a lista de Personal Trainer
  def list_pt_window
    PersonalTrainerListWindow.new.show_all
    hide
  end

  #Função que retorna para a janela de login
  def logout
    LoginWindow.new.show_all
    hide
  end

end