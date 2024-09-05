require 'gtk3'
require_relative 'LoginWindow'
require_relative 'ClientDeleteWindow'
require_relative 'ClientRegisterWindow'
require_relative 'AvaliationSearchClientWindow'
require_relative 'AvaliationDeleteWindow'
require_relative 'ExerciseRegisterWindow'
require_relative 'ExerciseDeleteWindow'

#Visão da Janela principal de Peronal Trainer
class PersonalTrainerMainWindow < Gtk::Window
  #Janela principal
  def initialize(id)
    super
    set_title 'GymTech'
    set_default_size 200, 100


    @id = id

    #BOTÕES
    register_client_button = Gtk::Button.new(label: 'Registrar Cliente')
    register_client_button.signal_connect('clicked') do
     register_client_window
    end

    register_avaliation_button = Gtk::Button.new(label: 'Fazer Avaliação')
    register_avaliation_button.signal_connect('clicked') do
        avaliation_search_client(1)
    end

    list_client_avaliation_button = Gtk::Button.new(label: 'Listar Avaliações de um Cliente')
    list_client_avaliation_button.signal_connect('clicked') do
      avaliation_search_client(2)
    end

    delete_avaliation_button = Gtk::Button.new(label: 'Deletar Avaliação')
    delete_avaliation_button.signal_connect('clicked') do
      delete_avaliation()
    end

    list_client_button = Gtk::Button.new(label: 'Listar Clientes')
    list_client_button.signal_connect('clicked') do
        list_client_window
    end

    delete_client_button = Gtk::Button.new(label: 'Deletar Cliente')
    delete_client_button.signal_connect('clicked') do
        delete_client_window
    end

    register_exercise_button = Gtk::Button.new(label: 'Cadastrar Exercício')
    register_exercise_button.signal_connect('clicked') do
        register_exercise_window
    end

    delete_exercise_button = Gtk::Button.new(label: 'Remover Exercício')
    delete_exercise_button.signal_connect('clicked') do
      delete_exercise_window
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
    box = Gtk::Box.new(:vertical, 10)
    box.add(register_client_button)
    box.add(register_avaliation_button)
    box.add(list_client_avaliation_button)
    box.add(delete_avaliation_button)
    box.add(list_client_button)
    box.add(delete_client_button)
    box.add(register_exercise_button)
    box.add(delete_exercise_button)
    box.add(logout_button)
    box.add(quit_button)

    add(box)
  end

  #FUNÇÃO QUE ABRE A JANELA DE REGISTRO DE CLIENTES
  def register_client_window
    ClientRegisterWindow.new(@id).show_all
    hide
  end

  #FUNÇÃO QUE ABRE A JANELA DE EXCLUSÃO DE CLIENTES
  def delete_client_window
    ClientDeleteWindow.new(@id).show_all
    hide
  end

  #FUNÇÃO QUE ABRE A JANELA DE LISTAGEM DE CLIENTES
  def list_client_window
    ClientListWindow.new(@id).show_all
    hide
  end

  # FUNÇÃO QUE ABRE A JANELA DE PESQUISA DE CLIENTE PARA AVALIAÇÕES
  def avaliation_search_client(type)
    AvaliationSearchClientWindow.new(@id, type).show_all
    hide
  end

  # FUNÇÃO QUE ABRE A JANELA DE REMOÇÃO DE AVALIAÇÕES
  def delete_avaliation()
    AvaliationDeleteWindow.new(@id).show_all
    hide
  end

  # FUNÇÃO QUE ABRE A JANELA DE CADASTRAR EXERCICIOS
  def register_exercise_window()
    ExerciseRegisterWindow.new(@id).show_all
    hide
  end

  # FUNÇÃO QUE DELETA UM EXERCICIO
  def delete_exercise_window()
    ExerciseDeleteWindow.new(@id).show_all
    hide
  end
  #Função de Logout
  def logout
    LoginWindow.new.show_all
    hide
  end

end
