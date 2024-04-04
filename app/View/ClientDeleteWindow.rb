require 'gtk3'

require_relative '../Controller/ClientController'

require_relative 'PersonalTrainerMainWindow'

# Visão da janela de Deletar Cliente
class ClientDeleteWindow < Gtk::Window

  #Janela Principal
  def initialize
    super
    set_title 'GymTech'
    set_default_size 200, 100

    #INPUTS
    id_input_entry = Gtk::Entry.new

    id_input_entry.placeholder_text = "Digite o ID do Cliente"

    #BOTÕES
    delete_client_button = Gtk::Button.new(label: 'Deletar')
    delete_client_button.signal_connect('clicked') do
        delete_client(id_input_entry.text)
    end

    backward_button = Gtk::Button.new(label: 'Voltar')
    backward_button.signal_connect('clicked') do
      backward_window
    end

    #CAIXA COM OS COMPONENTES DA JANELA
    box = Gtk::Box.new(:vertical, 5)
    box.add(id_input_entry)
    box.add(delete_client_button)
    box.add(backward_button)

    add(box)
  end

  #Função que redireciona para a página anterior
  def backward_window
    PersonalTrainerMainWindow.new.show_all
    hide
  end

  #Função que , utilizando o controlador, deleta um cliente baseando-se nos inputs
  def delete_client(id)
    controller = ClientController.new
    if controller.delete_client(id) == true
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
 