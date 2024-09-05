require 'gtk3'
require_relative 'WorkoutPlanMainWindow'
require_relative '../Controller/ExerciseController'
require_relative '../Controller/WorkoutPlanController'

# Visão da janela para seleção de exercícios em uma ficha de treino
class AvaliationMeasuresListWindow < Gtk::Window

  def initialize(avaliation_id, id_pt, id_client, count, workout_plan)
    super()
    set_title 'GymTech - Seleção de Exercícios'
    set_default_size 400, 600

    @id_client = id_client
    @id_pt = id_pt
    @count = count
    @workout_plan = workout_plan

    # Inicializando o layout vertical
    main_box = Gtk::Box.new(:vertical, 10)
    add(main_box)

    # Label para instrução
    instruction_label = Gtk::Label.new("Selecione os exercícios para cada dia da semana:")
    main_box.pack_start(instruction_label, expand: false, fill: false, padding: 10)

    # Criando uma área de seleção para cada dia da semana
    days_of_week = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday]
    days_of_week.each do |day|
      create_day_selection(main_box, day)
    end

    # Botão para salvar as seleções
    save_button = Gtk::Button.new(label: 'Salvar Ficha de Treino')
    save_button.signal_connect('clicked') { save_workout_plan }
    main_box.pack_start(save_button, expand: false, fill: false, padding: 10)

    # Botão para voltar à janela anterior
    backward_button = Gtk::Button.new(label: 'Voltar')
    backward_button.signal_connect('clicked') do
      backward_window
    end
    main_box.pack_start(backward_button, expand: false, fill: false, padding: 10)

    show_all
  end

  def create_day_selection(parent_box, day)
    controller = ExerciseController.new
    # Criando um frame para cada dia da semana
    day_frame = Gtk::Frame.new(day)
    parent_box.pack_start(day_frame, expand: false, fill: false, padding: 5)

    # Caixa vertical para os checkboxes dos exercícios
    exercise_box = Gtk::Box.new(:vertical, 5)
    day_frame.add(exercise_box)

    # Obtendo lista de exercícios (substitua com o método correto)
    exercises = controller.list_exercises

    # Criando um checkbox para cada exercício
    exercises.each do |exercise|
      checkbox = Gtk::CheckButton.new(label: exercise.name)
      checkbox.signal_connect('toggled') do |btn|
        toggle_exercise(day, exercise, btn.active?)
      end
      exercise_box.pack_start(checkbox, expand: false, fill: false, padding: 2)
    end
  end

  def toggle_exercise(day, exercise, add)
    # Adiciona ou remove o exercício da lista correspondente no plano de treino
    day_attr = "#{day.downcase}_exercises"
    if add
      @workout_plan.send(day_attr) << exercise
    else
      @workout_plan.send(day_attr).delete(exercise)
    end
  end

  def save_workout_plan
    # Salva as seleções de volta no plano de treino (implemente o método de salvar no controlador)
    WorkoutPlanController.new.save_workout_plan(@workout_plan)
    puts "Ficha de Treino salva com sucesso!"
  end

  def get_exercises_for_day(day)
    # Aqui você pode buscar os exercícios disponíveis (substitua com o método correto)
    ExerciseController.new.get_all_exercises
  end

  def backward_window
    WorkoutPlanMainWindow.new(@id_client, @id_pt, @count).show_all
    hide
  end
end
