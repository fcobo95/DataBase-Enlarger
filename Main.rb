require_relative 'DatabaseConnection'
require_relative 'NetworkHandlers'
class Main
  host = '192.168.1.5'
  user = 'erick'
  password = 'root'

  dbhost = '192.168.1.5'
  dbuser = 'sysadmin'
  dbname = 'postgres'
  dbpass = 'admin'

  database = DatabaseConnection.new(dbhost, dbname, dbuser, dbpass)
  # handlers = NetworkHandlers.new(host, user, password)

  database.connectToPG
  database.insert_to_vm_db
  if handlers.ssh_vm > 50
    handlers.scp_host
    handlers.sftp_to_vm
  end
end