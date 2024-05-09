require 'gtk3'
require_relative 'AdminMainWindow'

#Visão da janela Inicial do software
class PersonalTrainerListWindow < Gtk::Window

  #Janela Principal
  def initialize
    super
    set_title 'GymTech'
    set_default_size 200, 100


    backward_button = Gtk::Button.new(label: 'Voltar')
    backward_button.signal_connect('clicked') do
        backward_window
    end 


    #Cria um widget TextView para exibir os nomes dos Personal Trainers
    @text_view = Gtk::TextView.new
    @text_view.editable = false
    @text_view.cursor_visible = false
    
    #Obtém a lista de nomes dos Personal Trainers
    names = list_pt

    #Constrói a primeira linha da tabela com os cabeçalhos
    table_text = "Nome\tID\n"

    names.each do |name,id|
      table_text += "#{name}\t#{id}\n"
    end

    #Adiciona os nomes ao TextView
    @text_view.buffer.text = table_text

    #CAIXA COM OS COMPONENTES DA JANELA
    box = Gtk::Box.new(:vertical, 2)
    box.add(backward_button)
    box.add(@text_view)

    add(box)
  end

  #Função que redireciona para a janela de login principal
  def backward_window
    AdminMainWindow.new.show_all
    hide
  end


  #Função que retorna nome e id de todos os PT
  def list_pt
    controller = PersonalTrainerController.new
    pts = []
    namepts = []
    list = []
    ids = controller.list_pt
    for id in ids
        pts.push(controller.read_pt(id))
    end

    for pt in pts
        list.push([pt.name,pt.id])
    end
    return list
  end

end
