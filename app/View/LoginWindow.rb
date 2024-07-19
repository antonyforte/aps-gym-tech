require 'gtk3'

require_relative 'View'

require_relative '../Controller/ClientController'
require_relative '../Controller/PersonalTrainerController'

#Visão da Janela de login principal
class LoginWindow < Gtk::Window
  
  #Janela Principal
  def initialize
    super
    set_title 'Login'
    set_default_size 200, 100

    #INPUTS
    name_input_entry = Gtk::Entry.new
    password_input_entry = Gtk::Entry.new

    name_input_entry.placeholder_text = "Digite o seu nome"
    password_input_entry.placeholder_text = "Digite a sua senha"

    #BOTÕES
    enter_button = Gtk::Button.new(label: 'Entrar')
    enter_button.signal_connect('clicked') do
      logged_user(name_input_entry.text, password_input_entry.text)
    end

    backward_button = Gtk::Button.new(label: 'Voltar')
    backward_button.signal_connect('clicked') do
      backward_window
    end

    #CAIXA COM OS COMPONENTES DA JANELA
    box = Gtk::Box.new(:vertical, 4)
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

  #Verifica o tipo de usuário e inicia a janela correspondente a ele
  def logged_user(name,password)

    #Algoritmo para buscar o ID baseado no nome e senha
    client_controller = ClientController.new
    pt_controller = PersonalTrainerController.new
    allc = client_controller.list_client
    allp = pt_controller.list_pt
    all = []
    for c in allc 
      all.push(client_controller.read_client(c))
    end
    for p in allp
      all.push(pt_controller.read_pt(p))
    end
    id = 0
    for info in all
      if(info.name == name && info.password == password)
        id = info.id
        break
      end
    end
    if (id == 0)
      show_invalid_credentials_message
    else
      if verify_input(name,id) == 1

        open_pt_main_window(id)
  
      elsif verify_input(name,id) == 2
        open_client_main_window(id)
  
      else
        show_invalid_credentials_message
      end 
    end
    #Verifica o tipo de usuário(PT OU CLIENTE)
  end

  #abre a janela de cliente
  def open_client_main_window(id)
    ClientMainWindow.new(id).show_all
    hide
  end

  #abre a janela de personal trainer
  def open_pt_main_window(id)
    PersonalTrainerMainWindow.new(id).show_all()
    hide
  end

  #verifica se os inputs correspondem ha alguma conta registrada 0-nao ha, 1-conta personal trainer 2- conta cliente
  def verify_input(name,id)
    client_controller = ClientController.new
    pt_controller = PersonalTrainerController.new
    

    if id.start_with?("su")
      if pt_controller.login_authentication_verify(name,id) == true
        return 1
      else
        return 0
      end
    else
      if client_controller.login_authentication_verify(name,id) == true
        return 2
      else
        return 0
      end
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