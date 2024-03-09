# dns_enumerator.rb

require 'dnsruby'

module Colors
  ANSI_LILAS = "\e[95m"
  ANSI_CYAN = "\e[96m"
  ANSI_AMARELO = "\e[93m"
  ANSI_VERDE = "\e[32m"
  ANSI_RESET = "\e[0m"
end

class DnsEnumerator
  def initialize(domain)
    @domain = domain
    @results = {}
  end

  def enumerate_dns
    resolver = Dnsruby::Resolver.new

    # Consulta A para obter registros de subdomínios
    subdomains = query_records(resolver, @domain, 'A')
    @results['Subdomains'] = subdomains

    # Consulta MX para obter registros MX
    mx_records = query_records(resolver, @domain, 'MX')
    @results['MX Records'] = mx_records

    # Consulta NS para obter registros NS
    ns_records = query_records(resolver, @domain, 'NS')
    @results['NS Records'] = ns_records

    # Consulta TXT para obter registros TXT
    txt_records = query_records(resolver, @domain, 'TXT')
    @results['TXT Records'] = txt_records
  end

  def display_results
    @results.each do |category, records|
      case category
      when 'Subdomains'
        color = Colors::ANSI_LILAS
      when 'MX Records'
        color = Colors::ANSI_CYAN
      when 'NS Records'
        color = Colors::ANSI_AMARELO
      when 'TXT Records'
        color = Colors::ANSI_VERDE
      else
        color = Colors::ANSI_RESET
      end

      puts "#{color}==== #{category} ====#{Colors::ANSI_RESET}"
      records.each do |record|
        puts "#{color}#{record}#{Colors::ANSI_RESET}"
      end
      puts ""
    end
  end

  private

  def query_records(resolver, domain, type)
    response = resolver.query(domain, type)
    response.answer.map(&:to_s)
  rescue Dnsruby::NXDomain
    []
  rescue Dnsruby::ResolvError => e
    puts "#{Colors::ANSI_AMARELO}Erro ao consultar registros #{type}: #{e.message}#{Colors::ANSI_RESET}"
    []
  end
end
