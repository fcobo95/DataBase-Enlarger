require_relative 'DatabaseConnection'
$shared_conn
class Main
  dbhost = '192.168.1.5'
  dbuser = 'sysadmin'
  dbname = 'postgres'
  dbpass = 'admin'

  $shared_conn = DatabaseConnection.new(dbhost, dbname, dbuser, dbpass)

  $shared_conn.connectToPG
  $shared_conn.insert_to_vm_db
end