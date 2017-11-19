require 'net/ssh'
class DiskChecker
  Net::SSH.start('192.168.1.21', 'erick', :password => 'root') do |ssh|

    while true
      disk_space = ssh.exec!("df -h / | grep -o '[0-9][0-9]%*'")
      temp = disk_space.to_s
      used_space = temp.gsub("%", "")
      puts "Used disk space is: #{used_space}"
      space = used_space.to_i

      if space == 80
        puts "Creating Main Server Node............"
        system "VBoxManage clonevm 'Ubuntu Template' --name 'Ubuntu Server Slave Node' --register"
        system "VBoxManage startvm 'Ubuntu Server Slave Node'"
        sleep(5)
      end
    end
  end
end
