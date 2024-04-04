#Funções apenas para auxiilio no desenvolvimento do software

require 'fileutils'

def delete_files_in_folder(folder_path)
  Dir.glob("#{folder_path}/*").each do |file|
    File.delete(file) if File.file?(file)
  end
  puts "Arquivos em #{folder_path} deletados com sucesso."
end


def delete_cache(option)
  case option
  when 1
    delete_files_in_folder("database/avaliations")
  when 2
    delete_files_in_folder("database/clients")
  when 3
    delete_files_in_folder("database/pt")
  when 4
    delete_files_in_folder("database/wp")
  when 5
    delete_files_in_folder("database/avaliations")
    delete_files_in_folder("database/clients")
    delete_files_in_folder("database/pt")
    delete_files_in_folder("database/wp")
  else
    puts "Opção inválida"
  end
end

