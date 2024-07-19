require 'gtk3'
require_relative '../Controller/AvaliationController'
require_relative 'PersonalTrainerMainWindow'

# Visão da janela de registro de Clientes
class AvaliationRegisterWindow < Gtk::Window

  # Janela Principal, recebe um id do personal trainer e um do cliente
  def initialize(pt_id, client_id)
    super()
    set_title 'GymTech'
    set_default_size 200, 100

    @id_pt = pt_id
    @id_client = client_id

    # INPUTS
    height_input_entry = Gtk::Entry.new
    weight_input_entry = Gtk::Entry.new
    shoulder_input_entry = Gtk::Entry.new
    chest_input_entry = Gtk::Entry.new
    waist_input_entry = Gtk::Entry.new
    tummy_input_entry = Gtk::Entry.new
    hip_input_entry = Gtk::Entry.new
    arm_input_entry = Gtk::Entry.new
    forearm_input_entry = Gtk::Entry.new
    thigh_input_entry = Gtk::Entry.new
    calf_input_entry = Gtk::Entry.new

    # PLACEHOLDERS DOS INPUTS
    height_input_entry.placeholder_text = "Informe a Altura do Cliente"
    weight_input_entry.placeholder_text = "Informe o Peso do Cliente"
    shoulder_input_entry.placeholder_text = "Informe a Medida do Ombro do Cliente"
    chest_input_entry.placeholder_text = "Informe a Medida do Tórax do Cliente"
    waist_input_entry.placeholder_text = "Informe a Medida da Cintura do Cliente"
    tummy_input_entry.placeholder_text = "Informe a Medida do Abdômen do Cliente"
    hip_input_entry.placeholder_text = "Informe a Medida do Quadril do Cliente"
    arm_input_entry.placeholder_text = "Informe a Medida do Braço do Cliente"
    forearm_input_entry.placeholder_text = "Informe a Medida do Antebraço do Cliente"
    thigh_input_entry.placeholder_text = "Informe a Medida da Coxa do Cliente"
    calf_input_entry.placeholder_text = "Informe a Medida da Panturrilha do Cliente"

    # BOTÕES
    register_avaliation_button = Gtk::Button.new(label: 'Registrar')
    register_avaliation_button.signal_connect('clicked') do
      register_avaliation(height_input_entry.text,
      weight_input_entry.text,
      shoulder_input_entry.text,
      chest_input_entry.text,
      waist_input_entry.text,
      tummy_input_entry.text,
      hip_input_entry.text,
      arm_input_entry.text,
      forearm_input_entry.text,
      thigh_input_entry.text,
      calf_input_entry.text)
    end

    backward_button = Gtk::Button.new(label: 'Voltar')
    backward_button.signal_connect('clicked') do
      backward_window
    end

    # CAIXA COM OS COMPONENTES DA JANELA
    box = Gtk::Box.new(:vertical, 13)
    box.add(height_input_entry)
    box.add(weight_input_entry)
    box.add(shoulder_input_entry)
    box.add(chest_input_entry)
    box.add(waist_input_entry)
    box.add(tummy_input_entry)
    box.add(hip_input_entry)
    box.add(arm_input_entry)
    box.add(forearm_input_entry)
    box.add(thigh_input_entry)
    box.add(calf_input_entry)
    box.add(register_avaliation_button)
    box.add(backward_button)

    add(box)
  end

  # Função que redireciona para a janela anterior
  def backward_window
    PersonalTrainerMainWindow.new(@id_pt).show_all
    hide
  end

  # Função que utiliza um controlador para registrar uma avaliação
  def register_avaliation(height, weight, shoulder, chest, waist, tummy, hip, arm, forearm, thigh, calf)
    controller = AvaliationController.new
    controller.register_avaliation(@id_client, @id_pt, height, weight, shoulder, chest, waist, tummy, hip, arm, forearm, thigh, calf)
    backward_window
  end
end
