#Models
Dir["app/Model/*.rb"].each { |file| require_relative file }

#Views
Dir["app/View/*.rb"].each { |file| require_relative file }

#Controllers
Dir["app/Controller/*.rb"].each { |file| require_relative file}

#Persists
Dir["app/Persist/*.rb"].each { |file| require_relative file}


require_relative 'lib/utils'

=begin
delete_cache(5)

cpersist = ClientPersist::new
tpersist = PersonalTrainerPersist::new
apersist = AvaliationPersist::new

cpersist.create("Antonio",1,0)
cpersist.create("Angelo",2,0)
cpersist.create("Bianca",3,0)
cpersist.create("Bruna ",4,0)
cpersist.create("Bruna",5,0)
cpersist.create("Julio",6,0)
cpersist.create("Antonio",7,0)
cpersist.create("Antonio",8,0)


client = cpersist.read("Antonio")
puts "#{client.age}"
=end

win = MainWindow.new
win.signal_connect("destroy") {Gtk.main_quit}

win2 = PersonalTrainerLoginWindow.new
win.signal_connect("destroy") {Gtk.main_quit}
Gtk.main