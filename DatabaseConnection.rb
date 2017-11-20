$connection
require 'pg'
require 'socket'
class DatabaseConnection

  # THIS IS THE NETWORKHANDLERS CONSTRUCTOR OR INITIALIZER METHOD
  # PARAMETERS ARE
  # HOST=> IT'S THE IP OF THE VIRTUAL MACHINE TO MONITOR
  # DATABASE=> IT'S THE DATABASE WE ARE GOING TO CONNECT TO IN POSTGRES
  # USER=> IT'S THE DB ROLE TO CONNECT AS
  # PASSWORD=> IT'S THE ROLE'S PASSWORD

  # CONSTRUCTOR BEGINS

  def initialize(host, database, user, password)
    @host = host
    @database = database
    @user = user
    @password = password

  end

  # CONSTRUCTOR ENDS

  # DEF CONNECT_TO_PG STARTS

  # THIS METHOD CREATES THE PERSISTENT CONNECTION TO THE POSTGRES DB IN THE REMOTE SERVER
  def connect_to_pg
    $connection = PG::Connection.open(:host => @host, :dbname => @database,
                                      :user => @user, :password => @password)
  rescue PG::Error => error
    puts error.message
  end

  # DEF ENDS

  # DEF INSERT_TO_VM_DB STARTS

  # THIS METHOD INSERTS DATA INTO THE LOGGER TABLE IN THE REMOTE DATABASE, AS AN EXAMPLE OF HOW FAST A
  # DATABASE CAN GROW AND HOW FAST A PROGRAM IS MEANT TO RESPOND TO CHANGE WITHOUT AFFECTING THE SERVICE.
  def insert_to_vm_db
    counter = 0
    user = Socket.gethostname
    ip = Socket.ip_address_list
    ifconfig = Socket.getifaddrs

    while true
      message = "Logged the user: #{user} on IP #{ip} that is inserting values in the logger table. This is junk text: #{ifconfig}"
      $connection.exec "INSERT INTO logger (id, message) VALUES(#{counter}, '#{message}')"
      puts message
      puts counter
      counter += 1
    end
  end

  # DEF ENDS

  # DOESN'T WORK AS DESIRED IN THE NETWORKHANDLERS.
  def truncate_logger
    $connection.exec("TRUNCATE TABLE logger CASCADE")
  end
end

