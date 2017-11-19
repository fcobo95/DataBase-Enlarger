require 'net/ssh'
require_relative 'data_base_connection'
class DiskChecker
  database = DataBaseConnection.new('192.168.1.21', 'postgres', 'sysadmin', 'admin')

  database.connectToPG

  Net::SSH.start('192.168.1.21', 'erick', :password => 'root') do |ssh|
    theUser = Socket.gethostname
    theIP = Socket.ip_address_list
    theMessage = 'User is checking the disk space on remote database.'
    while true
      disk_space = ssh.exec!("df -h / | grep -o '[0-9][0-9]%*'")
      temp = disk_space.to_s
      used_space = temp.gsub("%", "")
      puts "Used disk space is: #{used_space}"
      space = used_space.to_i

      if space == 50
        # puts "Creating Main Server Node............"
        # system "VBoxManage clonevm 'Ubuntu Template' --name 'Ubuntu Server Slave Node' --register"
        # system "VBoxManage startvm 'Ubuntu Server Slave Node'"
        # sleep(5)
        ssh.exec!("pg_dump postgres > postgres_dump.sql")
        database.truncateLogger
        break
      end
    end
  end
end
