require 'gtk3'

class MainWindow < Gtk::Window
  def initialize
    super
    set_title "Gymtech"
    set_default_size 300, 200
    set_border_width 10

    # Box principal vertical
    vbox = Gtk::Box.new(:vertical, 5)
    add(vbox)

    # Botão "Registrar Cliente"
    button_registrar_cliente = Gtk::Button.new(label: "Registrar Cliente")
    vbox.pack_start(button_registrar_cliente, expand: true, fill: true, padding: 0)

    # Botão "Realizar Avaliação"
    button_realizar_avaliacao = Gtk::Button.new(label: "Realizar Avaliação")
    vbox.pack_start(button_realizar_avaliacao, expand: true, fill: true, padding: 0)

    # Botão "Admin"
    button_admin = Gtk::Button.new(label: "Admin")
    button_admin.override_background_color(:normal, Gdk::RGBA.new(0.6, 0.2, 0.2, 1.0)) # Cor de fundo verde
    vbox.pack_end(button_admin, expand: false, fill: false, padding: 0)

    show_all
  end
end

