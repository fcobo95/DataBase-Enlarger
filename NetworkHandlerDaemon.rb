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

  handlers = NetworkHandlers.new(host, user, password)

  while true
    check_space = handlers.ssh_vm_for_space

    if check_space
      handlers.ssh_vm_crbackup
      handlers.scp_host_for_backupdl
      handlers.sftp_to_vm_rmbackup
      handlers.ssh_for_clean
      database.truncate_logger
    end
  end

end