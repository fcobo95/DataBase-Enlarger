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
  database.insert_to_vm_db
end