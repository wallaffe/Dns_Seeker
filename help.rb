# help.rb

module Help
  ANSI_LILAS = "\e[95m"
  ANSI_CYAN = "\e[96m"
  ANSI_AMARELO = "\e[93m"
  ANSI_RESET = "\e[0m"

  def self.display_help
    puts "\n#{ANSI_LILAS}Ajuda:#{ANSI_RESET}"
    puts "#{ANSI_AMARELO}MX Records:#{ANSI_RESET}      Registros de correio (Mail Exchange) - especificam os servidores de correio responsáveis por receber e encaminhar e-mails para o domínio."
    puts "#{ANSI_CYAN}NS Records:#{ANSI_RESET}      Registros de servidor de nome (Name Server) - especificam os servidores de nomes autorizados para o domínio."
    puts "#{ANSI_AMARELO}TXT Records:#{ANSI_RESET}      Registros de texto (Text) - podem conter informações de texto arbitrário associadas ao domínio, como verificações de propriedade, políticas de SPF, etc."
  end
end
