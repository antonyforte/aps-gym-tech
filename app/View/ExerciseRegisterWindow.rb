require 'gtk3'
require_relative '../Controller/ExerciseController'
require_relative 'PersonalTrainerMainWindow'

# Visão da janela de registro de Exercicios
class ExerciseRegisterWindow < Gtk::Window

  # Janela Principal, recebe um id do personal trainer
  def initialize(id)
    super()
    set_title 'GymTech'
    set_default_size 200, 100

    @id = id

    # INPUTS
    num_input_entry = Gtk::Entry.new
    name_input_entry = Gtk::Entry.new
    series_input_entry = Gtk::Entry.new
    reps_input_entry = Gtk::Entry.new

    # PLACEHOLDERS DOS INPUTS
    num_input_entry.placeholder_text = "Informe o Número do Aparelho"
    name_input_entry.placeholder_text = "Informe o Nome do Exercício"
    series_input_entry.placeholder_text = "Informe a Quantidade de Séries"
    reps_input_entry.placeholder_text = "Informe a Quantidade de Repetições"

    # BOTÕES
    register_exercise_button = Gtk::Button.new(label: 'Registrar')
    register_exercise_button.signal_connect('clicked') do
      register_exercise(num_input_entry.text,
      name_input_entry.text,
      series_input_entry.text,
      reps_input_entry.text)
    end

    backward_button = Gtk::Button.new(label: 'Voltar')
    backward_button.signal_connect('clicked') do
      backward_window
    end

    # CAIXA COM OS COMPONENTES DA JANELA
    box = Gtk::Box.new(:vertical, 6)
    box.add(num_input_entry)
    box.add(name_input_entry)
    box.add(series_input_entry)
    box.add(reps_input_entry)
    box.add(register_exercise_button)
    box.add(backward_button)

    add(box)
  end

  # Função que redireciona para a janela anterior
  def backward_window
    PersonalTrainerMainWindow.new(@id).show_all
    hide
  end

  # Função que utiliza um controlador para registrar um exercicio
  def register_exercise(num, name, series, reps)
    controller = ExerciseController.new
    controller.register_exercise(num,name,series,reps)
    backward_window
  end
end
