require 'gtk3'
require_relative 'LoginWindow'
require_relative 'AdminLoginWindow'

#Visão da janela Inicial do software
class View < Gtk::Window

  #Janela Principal
  def initialize
    super
    set_title 'GymTech'
    set_default_size 200, 100

    #BOTÕES
    login_button = Gtk::Button.new(label: 'Login')
    login_button.signal_connect('clicked') do
      open_loginwindow
    end

    

    admin_button = Gtk::Button.new(label: 'Admin')
    admin_button.override_background_color(:normal, Gdk::RGBA.new(7,0,0,1))
    admin_button.signal_connect('clicked') do
      open_adminloginwindow
    end


    quit_button = Gtk::Button.new(label: 'Quit')
    quit_button.signal_connect('clicked') do
      Gtk.main_quit
    end

    

    #CAIXA COM OS COMPONENTES DA JANELA
    box = Gtk::Box.new(:vertical, 3)
    box.add(login_button)
    box.add(admin_button)
    box.add(quit_button)
    

    add(box)
  end

  #Função que redireciona para a janela de login principal
  def open_loginwindow
    LoginWindow.new.show_all
    hide
  end

  #Função que redireciona para a janela de login de admin
  def open_adminloginwindow
    AdminLoginWindow.new.show_all
    hide
  end

  #Função tree, que é utilizada no arquivo de execução do software para iniciar as views
  def run_view
    run = View.new
    run.signal_connect('delete-event') { Gtk.main_quit }
    run.show_all
    Gtk.main
  end
end
