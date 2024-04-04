#INCLUSÃO DO MVC

#Models
Dir["app/Model/*.rb"].each { |file| require_relative file }

#Views
Dir["app/View/*.rb"].each { |file| require_relative file }

#Controllers
Dir["app/Controller/*.rb"].each { |file| require_relative file}

#Persists
Dir["app/Persist/*.rb"].each { |file| require_relative file}


require_relative 'lib/utils'

#Funções para limpar o banco de dados
=begin
delete_cache(1) #1 - Avaliações
delete_cache(2) #2 - Clientes
delete_cache(3) #3 - Personal Trainers
delete_cache(4) #4 - Tudo
=end

#Inicialização da Interface do Software

view_start = View.new
view_start.run_view