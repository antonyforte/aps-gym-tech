require 'gtk3'
require_relative '../Controller/ClientController'
require_relative 'PersonalTrainerMainWindow'
require_relative 'AvaliationRegisterWindow'

# Visão da janela de Pesquisar
class AvaliationSearchClientWindow < Gtk::Window

  # Janela Principal, recebe o ID do personal trainer e o tipo de página a qual a pesquisa deve chamar(1-fazer avaliação. 2-listar avaliação)
  def initialize(id, type)
    super()
    set_title 'GymTech'
    set_default_size 200, 100

    @id_pt = id
    @type = type

    # INPUTS
    id_input_entry = Gtk::Entry.new
    id_input_entry.placeholder_text = "Digite o ID do Cliente"

    # BOTÕES
    search_client_button = Gtk::Button.new(label: 'Avançar')
    search_client_button.signal_connect('clicked') do
      search_client(id_input_entry.text)
    end

    backward_button = Gtk::Button.new(label: 'Voltar')
    backward_button.signal_connect('clicked') do
      backward_window
    end

    # CAIXA COM OS COMPONENTES DA JANELA
    box = Gtk::Box.new(:vertical, 3)
    box.add(id_input_entry)
    box.add(search_client_button)
    box.add(backward_button)

    add(box)
  end

  # Função que redireciona para a página anterior
  def backward_window
    PersonalTrainerMainWindow.new(@id_pt).show_all
    hide
  end

  # Função que utiliza o controlador para procurar um cliente baseando-se nos inputs
  def search_client(id)
    controller = ClientController.new
    if controller.read_client(id)
      if (@type == 1)
        AvaliationRegisterWindow.new(@id_pt, id).show_all
        hide
      elsif (@type == 2)
        AvaliationListWindow.new(@id_pt,id, 0).show_all
        hide
      else
        puts("Erro no tipo de Seleção da janela de Pesquisa de Avaliação")
      end
    else
      show_invalid_credentials_message
    end
  end

  # Função que retorna a janela principal com uma mensagem de erro nas credenciais
  def show_invalid_credentials_message
    dialog = Gtk::MessageDialog.new(parent: self,
                                    flags: :destroy_with_parent,
                                    type: :error,
                                    buttons: :ok,
                                    message: "Credenciais inválidas")
    dialog.run
    dialog.destroy
  end
end
