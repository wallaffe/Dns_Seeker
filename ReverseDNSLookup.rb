# ReverseDNSLookup.rb

require 'resolv'

module ReverseDNSLookup
  def self.lookup(ip_address)
    begin
      hostname = Resolv.getname(ip_address)
      return hostname
    rescue Resolv::ResolvError => e
      return nil
    end
  end
end
