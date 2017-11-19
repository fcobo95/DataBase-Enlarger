require_relative 'data_base_connection'
class Main
  database = DataBaseConnection.new('192.168.1.21', 'postgres', 'sysadmin', 'admin')

  database.connectToPG
  database.insertToRemoteDB
end