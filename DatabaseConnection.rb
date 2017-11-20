$connection
require 'pg'
require 'socket'
class DatabaseConnection

  def initialize(host, dbname, user, password)
    @host = host
    @dbname = dbname
    @user = user
    @password = password

  end

  def connectToPG
    $connection = PG::Connection.open(:host => @host, :dbname => @dbname,
                                      :user => @user, :password => @password)
  rescue PG::Error => error
    puts error.message
  end

  def insert_to_vm_db
    counter = 0
    user = Socket.gethostname
    ip = Socket.ip_address_list
    ifconfig = Socket.getifaddrs

    while true
      message = "Logged the user: #{user} on IP #{ip} that is inserting values in the logger table. This is junk text: #{ifconfig}"
      $connection.exec "INSERT INTO logger (id, message) VALUES(#{counter}, '#{message}')"
      sleep 0.0001
      puts message
      puts counter
      counter += 1
    end
  end

  def truncate_logger
    $connection.exec("TRUNCATE TABLE logger CASCADE")
  end
end