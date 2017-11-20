require_relative 'DatabaseConnection'
require_relative 'NetworkHandlers'
class Main
  host = '192.168.100.5'
  user = 'erick'
  password = 'root'

  dbhost = '192.168.100.5'
  dbuser = 'sysadmin'
  dbname = 'postgres'
  dbpass = 'root'

  database = DatabaseConnection.new(dbhost, dbname, dbuser, dbpass)
  handlers = NetworkHandlers.new(host, user, password)

  database.connectToPG
  handlers.ssh_vm
end