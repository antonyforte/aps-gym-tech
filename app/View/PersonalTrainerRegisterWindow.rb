require 'gtk3'

require_relative '../Controller/ClientController'

require_relative 'AdminMainWindow'

#Visão da janela de Registro de Personal Trainer
class PersonalTrainerRegisterWindow < Gtk::Window
  
  #Janela Principal
  def initialize
    super
    set_title 'GymTech'
    set_default_size 200, 100


    #INPUTS
    name_input_entry = Gtk::Entry.new
    cell_number_input_entry = Gtk::Entry.new
    salary_input_entry = Gtk::Entry.new

    name_input_entry.placeholder_text = "Digite o Nome Completo do Personal Trainer"
    cell_number_input_entry.placeholder_text = "Digite o número do Personal Trainer"
    salary_input_entry.placeholder_text = "Digite o salário do Cliente"

    #BOTÕES
    register_pt_button = Gtk::Button.new(label: 'Registrar')
    register_pt_button.signal_connect('clicked') do
        register_pt(name_input_entry.text,cell_number_input_entry.text,salary_input_entry.text)
    end

    backward_button = Gtk::Button.new(label: 'Voltar')
    backward_button.signal_connect('clicked') do
      backward_window
    end

    #CAIXA COM OS COMPONENTES DA JANELA
    box = Gtk::Box.new(:vertical, 5)
    box.add(name_input_entry)
    box.add(cell_number_input_entry)
    box.add(salary_input_entry)
    box.add(register_pt_button)
    box.add(backward_button)

    add(box)
  end

  #Função que retorna para a janela anterior
  def backward_window
    AdminMainWindow.new.show_all
    hide
  end

  #Função que, utilizando um controlador, registra um Personal Trainer
  def register_pt(name,cell_number,salary)
    controller = PersonalTrainerController.new
    controller.register_pt(name,cell_number,salary)
    backward_window
  end

end
 