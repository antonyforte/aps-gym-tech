require 'gtk3'

class PersonalTrainerLoginWindow < Gtk::Window
  def initialize
    super
    set_title "Login"
    set_default_size 300, 200
    set_border_width 10

    # Box principal vertical
    vbox = Gtk::Box.new(:vertical, 5)
    add(vbox)

    # Campo de entrada para o nome
    @entry_nome = Gtk::Entry.new
    @entry_nome.set_placeholder_text("Nome")
    vbox.pack_start(@entry_nome, expand: false, fill: false, padding: 0)

    # Campo de entrada para o ID
    @entry_id = Gtk::Entry.new
    @entry_id.set_placeholder_text("ID")
    vbox.pack_start(@entry_id, expand: false, fill: false, padding: 0)

    # Botão "Logar"
    button_logar = Gtk::Button.new(label: "Logar")
    button_logar.signal_connect("clicked") { logar }
    vbox.pack_start(button_logar, expand: false, fill: false, padding: 0)

    show_all
  end

  def logar
    nome = @entry_nome.text
    id = @entry_id.text
    puts "Nome: #{nome}, ID: #{id}"
  end
end
