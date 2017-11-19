$connection
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

    $connection = PG::Connection.open(:host => @theHostAddr, :dbname => @theDBName,
                                      :user => @theUser, :password => @theUserPass)

  rescue PG::Error => e
    puts e.message

  end

  def insert
    counter = 0
    user = Socket.gethostname
    ip = Socket.getifaddrs
    while true
      message = "Logged the user: #{user} on IP #{ip}"
      $connection.exec "INSERT INTO logger (id, message) VALUES(#{counter}, '#{message}')"
      puts message
      puts counter
      counter += 1
    end
  end
end