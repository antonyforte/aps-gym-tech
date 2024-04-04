require 'gtk3'

require_relative '../Controller/PersonalTrainerController'

require_relative 'AdminMainWindow'

#Visão da janela de deletar um Personal Trainer
class PersonalTrainerDeleteWindow < Gtk::Window

  #Janela Principal
  def initialize
    super
    set_title 'GymTech'
    set_default_size 200, 100

    #INPUTS
    id_input_entry = Gtk::Entry.new

    id_input_entry.placeholder_text = "Digite o ID do Personal Trainer"

    #BOTÕES
    delete_pt_button = Gtk::Button.new(label: 'Deletar')
    delete_pt_button.signal_connect('clicked') do
        delete_pt(id_input_entry.text)
    end

    backward_button = Gtk::Button.new(label: 'Voltar')
    backward_button.signal_connect('clicked') do
      backward_window
    end

    #CAIXA COM OS COMPONENTES DA JANELA
    box = Gtk::Box.new(:vertical, 5)
    box.add(id_input_entry)
    box.add(delete_pt_button)
    box.add(backward_button)

    add(box)
  end

  #Função que retorna para a janela anterior
  def backward_window
    PersonalTrainerMainWindow.new.show_all
    hide
  end

  #Função que utilizando um controlador deleta um Personal Trainer
  def delete_pt(id)
    controller = PersonalTrainerController.new
    if controller.delete_pt(id) == true
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
 