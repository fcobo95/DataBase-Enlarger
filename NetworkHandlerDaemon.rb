require_relative 'NetworkHandlers'
require_relative 'DataBase'
class Main

  dbhost = '192.168.1.5'
  dbuser = 'sysadmin'
  dbname = 'postgres'
  dbpass = 'admin'

  # NEW POSTGRES DATABASE OBJECT
  database = DatabaseConnection.new(dbhost, dbname, dbuser, dbpass)

  # ROUTINES TO COMPLETE. THIS CONNECTS TO THE DB AND INSERTS A LOT OF VALUES INTO THE LOGGER TABLE.
  database.connect_to_pg

  host = '192.168.1.5'
  user = 'erick'
  password = 'root'

  # NETWORKHANDLERS OBJECT
  handlers = NetworkHandlers.new(host, user, password)

  # THIS WILL ALLOW THE DAEMON TO MONITOR DISK SPACE IN REMOTE SERVER AND EXECUTE A BLOCK OF INSTRUCTIONS IN CASE
  # THE DISK SPACE IS CLOSE TO THE CONDITION.
  while true
    check_space = handlers.ssh_vm_for_space
    sleep(1)
    if check_space
      handlers.ssh_vm_crbackup
      database.truncate_logger
      handlers.scp_host_for_backupdl
      handlers.sftp_to_vm_rmbackup
      handlers.ssh_for_clean
    end
  end

end