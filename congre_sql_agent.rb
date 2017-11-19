require 'net/ssh'
class CongreSQLAgent
  Net::SSH.start('192.168.56.105', 'erick', :password => 'root') do |ssh|

    while true
      disk_space = ssh.exec!("df -h / | grep -o '[0-9][0-9]%*'")
      temp = disk_space.to_s
      used_space = temp.gsub("%", "")

      puts "Used disk space is: #{used_space}"

      check_to_expand = used_space.to_i
      if used_space == '30'
        puts "Creating Main Server Node............"
        system "VBoxManage clonevm 'Ubuntu Server Template' --name 'Ubuntu Server Main Node' --register"
        system "VBoxManage startvm 'Ubuntu Server Main Node'"
        sleep(50)
      end
    end
  end
end