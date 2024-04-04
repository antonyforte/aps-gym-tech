require 'gtk3'

require_relative 'View'

require_relative '../Controller/ClientController'
require_relative '../Controller/PersonalTrainerController'

# Visão da Janela de Login do Janela de Administrador ##SERVE PARA FAZER O LOGIN DO ADMINISTRADOR
class AdminLoginWindow < Gtk::Window
  
  
  #Função que inicia a janela
  def initialize
    super
    set_title 'Login'
    set_default_size 200, 100

    #INPUTS
    name_input_entry = Gtk::Entry.new
    password_input_entry = Gtk::Entry.new

    #PLACEHOLDER DOS INPUTS
    name_input_entry.placeholder_text = "Digite o user"
    password_input_entry.placeholder_text = "Digite a senha"

    #BOTÕES
    enter_button = Gtk::Button.new(label: 'Entrar')
    enter_button.signal_connect('clicked') do
      verify_input(name_input_entry.text, password_input_entry.text)
    end

    backward_button = Gtk::Button.new(label: 'Voltar')
    backward_button.signal_connect('clicked') do
      backward_window
    end

    #CAIXA COM OS COMPONENTES DA JANELA
    box = Gtk::Box.new(:vertical, 5)
    box.add(name_input_entry)
    box.add(password_input_entry)
    box.add(enter_button)
    box.add(backward_button)

    add(box)
  end

  
  #Retorna para a janela anterior
  def backward_window
      View.new.show_all
      hide
  end

  #abre a janela de cliente
  def open_admin_main_window
    AdminMainWindow.new.show_all
    hide
  end

  #verifica se os inputs correspondem ha alguma conta registrada 0-nao ha, 1-conta personal trainer 2- conta cliente
  def verify_input(name,password)
    if name == "admin" && password == "creatina"
        open_admin_main_window
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

