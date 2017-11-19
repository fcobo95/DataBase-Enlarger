$theConnection
require 'pg'
require 'socket'
class DataBaseConnection

  def initialize(theHost, theDBName, theUser, thePassword)
    @theHostAddr = theHost
    @theDBName = theDBName
    @theUser = theUser
    @theUserPass = thePassword

  end

  def connectToPG

    $theConnection = PG::Connection.open(:host => @theHostAddr, :dbname => @theDBName,
                                      :user => @theUser, :password => @theUserPass)

  rescue PG::Error => e
    puts e.message

  end

  def insertToRemoteDB
    counter = 0
    user = Socket.gethostname
    ip = Socket.ip_address_list
    ifconfig = Socket.getifaddrs

    while true
      message = "Logged the user: #{user} on IP #{ip} that is inserting values in the logger table. This is junk text: #{ifconfig}"
      $theConnection.exec "INSERT INTO logger (id, message) VALUES(#{counter}, '#{message}')"
      sleep 0.001
      puts message
      puts counter
      counter += 1
    end
  end

  def truncateLogger
    $theConnection.exec("TRUNCATE TABLE logger CASCADE")
  end
end