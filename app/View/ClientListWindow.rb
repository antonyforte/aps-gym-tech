require 'gtk3'
require_relative 'PersonalTrainerMainWindow'

#Visão da janela Inicial do software
class ClientListWindow < Gtk::Window

  #Janela Principal
  def initialize(id)
    super()
    set_title 'GymTech'
    set_default_size 200, 100

    @id = id

    backward_button = Gtk::Button.new(label: 'Voltar')
    backward_button.signal_connect('clicked') do
        backward_window
    end 


    #Cria um widget TextView para exibir os nomes dos Personal Trainers
    @text_view = Gtk::TextView.new
    @text_view.editable = false
    @text_view.cursor_visible = false
    
    #Obtém a lista de nomes dos Personal Trainers
    names = list_client

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
    PersonalTrainerMainWindow.new(@id).show_all
    hide
  end

  #Função que retorna uma lista com o nome e id de todos os clientes
  def list_client
    controller = ClientController.new
    clients = []
    list = []
    
    #Salva todos os ids dos clientes cadastrados em ids
    ids = controller.list_client

    #Salva todos os clientes cadastrados em ids
    for id in ids
        clients.push(controller.read_client(id))
    end

    #Salva todos os nomes e ids dos clientes cadastrados em list
    for client in clients
        list.push([client.name,client.id])
    end
    return list
  end
end
