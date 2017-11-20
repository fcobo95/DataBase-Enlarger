require_relative 'DatabaseConnection'
require_relative 'NetworkHandlers'
class Main
  host = '192.168.1.5'
  user = 'erick'
  password = 'root'

  handlers = NetworkHandlers.new(host, user, password)
  handlers.ssh_vm
end