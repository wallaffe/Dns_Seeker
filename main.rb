require_relative 'dns_enumerator'
require_relative 'help'
require_relative 'ReverseDNSLookup'

class Main
  # Adiciona constantes para definir as cores ANSI
  ANSI_AZUL = "\e[34m" # Azul
  ANSI_RESET = "\e[0m" # Resetar formatação

  def self.clear_terminal
    system 'clear' or system 'cls'
  end

  def self.main
    puts "Bem-vindo ao DNS Seeker!"

    loop do
      puts "\nEscolha uma opção:"
      puts "1. Checar DNS"
      puts "2. Checar DNS Reverso"
      puts "3. Ajuda"
      puts "4. Sair"
      print "> "
      option = gets.chomp.to_i

      case option
      when 1
        clear_terminal
        print "#{ANSI_AZUL}> #{ANSI_RESET}Por favor, insira o domínio que você deseja enumerar: "
        domain = gets.chomp

        enumerator = DnsEnumerator.new(domain)
        enumerator.enumerate_dns

        puts "Resultado da enumeração de DNS para o domínio #{domain}:"
        enumerator.display_results
      when 2
        clear_terminal
        print "#{ANSI_AZUL}> #{ANSI_RESET}Por favor, insira o endereço IP que você deseja consultar: "
        ip_address = gets.chomp

        hostname = ReverseDNSLookup.lookup(ip_address)

        if hostname
          puts "O nome de domínio associado ao endereço IP #{ip_address} é: #{hostname}"
        else
          puts "Não foi possível encontrar um nome de domínio para o endereço IP #{ip_address}"
        end
      when 3
        clear_terminal
        Help.display_help
      when 4
        clear_terminal
        puts "Saindo..."
        break
      else
        puts "Opção inválida. Tente novamente."
      end
    end
  end
end

Main.main if __FILE__ == $PROGRAM_NAME
