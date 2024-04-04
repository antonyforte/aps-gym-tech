require 'gtk3'

require_relative '../Controller/ClientController'

require_relative 'PersonalTrainerMainWindow'

# Visão da janela de registro de Clientes
class ClientRegisterWindow < Gtk::Window
  
  # Janela Principal
  def initialize
    super
    set_title 'GymTech'
    set_default_size 200, 100

    #INPUTS
    name_input_entry = Gtk::Entry.new
    age_input_entry = Gtk::Entry.new
    cell_number_input_entry = Gtk::Entry.new

    #PLACEHOLDERS DOS INPUTS
    name_input_entry.placeholder_text = "Digite o Nome Completo do Cliente"
    age_input_entry.placeholder_text = "Digite a Idade do Cliente"
    cell_number_input_entry.placeholder_text = "Digite o número do Cliente"

        
    #BOTÕES
    register_client_button = Gtk::Button.new(label: 'Registrar')
    register_client_button.signal_connect('clicked') do
        register_client(name_input_entry.text,age_input_entry.text,cell_number_input_entry.text)
    end

    backward_button = Gtk::Button.new(label: 'Voltar')
    backward_button.signal_connect('clicked') do
      backward_window
    end

    #CAIXA COM OS COMPONENTES DA JANELA
    box = Gtk::Box.new(:vertical, 5)
    box.add(name_input_entry)
    box.add(age_input_entry)
    box.add(cell_number_input_entry)
    box.add(register_client_button)
    box.add(backward_button)

    add(box)
  end

  #Função que redireciona para a janela anterior
  def backward_window
    PersonalTrainerMainWindow.new.show_all
    hide
  end

  #Função que utilizando um controlador, registra um cliente 
  def register_client(name,age,cell_number)
    controller = ClientController.new
    controller.register_client(name,age,cell_number)
    backward_window
  end

end
 