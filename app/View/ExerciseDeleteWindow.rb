require 'gtk3'

require_relative '../Controller/ExerciseController'

require_relative 'PersonalTrainerMainWindow'

# Visão da janela de Deletar Exercicio
class ExerciseDeleteWindow < Gtk::Window

  #Janela Principal recebe o ID do Personal Trainer
  def initialize(id)
    super()
    set_title 'GymTech'
    set_default_size 200, 100

    @id = id
    #INPUTS
    id_input_entry = Gtk::Entry.new

    id_input_entry.placeholder_text = "Digite o ID do Exercicio"

    #BOTÕES
    delete_exercise_button = Gtk::Button.new(label: 'Deletar')
    delete_exercise_button.signal_connect('clicked') do
        delete_exercise(id_input_entry.text)
    end

    backward_button = Gtk::Button.new(label: 'Voltar')
    backward_button.signal_connect('clicked') do
      backward_window
    end

    #CAIXA COM OS COMPONENTES DA JANELA
    box = Gtk::Box.new(:vertical, 3)
    box.add(id_input_entry)
    box.add(delete_exercise_button)
    box.add(backward_button)

    add(box)
  end

  #Função que redireciona para a página anterior
  def backward_window
    PersonalTrainerMainWindow.new(@id).show_all
    hide
  end

  #Função que , utilizando o controlador, deleta um exercicio pelo id
  def delete_exercise(id)
    controller = ExerciseController.new
    if controller.delete_exercise(id) == true
        backward_window
    else
        show_invalid_credentials_message
    end
  end

  #Função que retorna a janela principal com uma mensagem de erro nas credenciais
  def show_invalid_credentials_message
    dialog = Gtk::MessageDialog.new(parent: self,
                                     flags: Gtk::DialogFlags::DESTROY_WITH_PARENT,
                                     type: Gtk::MessageType::ERROR,
                                     buttons: Gtk::ButtonsType::OK,
                                     message: "Credenciais inválidas")
    dialog.run
    dialog.destroy
  end
end
 