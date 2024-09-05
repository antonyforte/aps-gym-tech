require 'gtk3'
require_relative 'AvaliationListWindow'

#Visão da janela Inicial do software
class WorkoutPlanMainWindow < Gtk::Window

  #Janela Principal
  def initialize(id,id_pt,id_client, count)
    super()
    set_title 'GymTech'
    set_default_size 200, 100

    @id = id
    @count = count
    @id_client = id_client
    @id_pt = id_pt

    puts "ID = #{id}"
    wp = list_exercises(id)
    
    dias_da_semana = {
      "Segunda-feira" => wp.monday_exercises,
      "Terça-feira" => wp.tuesday_exercises,
      "Quarta-feira" => wp.wednesday_exercises,
      "Quinta-feira" => wp.thursday_exercises,
      "Sexta-feira" => wp.friday_exercises,
      "Sábado" => wp.saturday_exercises,
      "Domingo" => wp.sunday_exercises
    }
    dbox = Gtk::Box.new(:vertical, 5)
    @text_view = Gtk::TextView.new
    @text_view.editable = false
    @text_view.cursor_visible = false
    table_text = ""
    wp.instance_variables.each do |var|
      
      next if var == :@id
      dia = wp.instance_variable_get(var)

      table_text += "\n\n#{var}\tSéries\tRepetições\n\n"


      dia.each do |exe|
        exercicio = exercicio_controller.read_exercise(exercicio)
        table_text += "#{exercicio.name}\t #{exercicio.series}\t #{exercicio.reps}"
      end
    end
    
    @text_view.buffer.text = table_text
    dbox.add(@text_view)


    backward_button = Gtk::Button.new(label: 'Voltar')
    backward_button.signal_connect('clicked') do
        backward_window
    end
    
    change_wp_button = Gtk::Button.new(label: 'Alterar Ficha de Treino')
    change_wp_button.signal_connect('clicked') do
      change_wp_window
    end


    box = Gtk::Box.new(:vertical, 3)
    box.add(backward_button)
    box.add(change_wp_button)
    box.add(dbox)

    add(box)
  end

  #Função que redireciona para a janela de login principal
  def backward_window
    PersonalTrainerMainWindow.new(@id_pt).show_all
    hide
  end

  def change_wp_window
    WorkoutPlanRegisterExercisesWindow.new(id,id_pt,id_client, count).show_all
    hide
  end

  def list_exercises(id)
    controller = WorkoutPlanController.new
    return controller.read(id) 
  end
end
