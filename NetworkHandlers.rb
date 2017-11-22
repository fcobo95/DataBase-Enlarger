require 'net/ssh'
require 'net/scp'
require 'net/sftp'
$need_space
class NetworkHandlers

  def initialize(host, user, password)
    @host = host
    @user = user
    @password = password
  end

  # THIS METHOD USES THE SSH PROTOCOL TO SEND THE REMOTE SERVER A COMMAND TO SCP THE BACKUPFILE TO THE HOST MACHINE.
  def scp_host_for_backupdl
    Net::SSH.start(@host, @user, :password => @password) do |ssh|
      ssh.exec!('scp /home/erick/pg_exemplar.sql ecobo95@192.168.1.9:/home/ecobo95/')
    end #DO ENDS
  end

  # THIS METHOD CONNECTS TO REMOTE SERVER VIA SFTP PROTOCOL TO DELETE THE DUMP GENERATED, THIS LIBERATES SPACE ON REMOTE SERVER
  def sftp_to_vm_rmbackup
    Net::SFTP.start(@host, @user, :password => @password) do |sftp|
      sftp.remove!('/home/erick/pg_exemplar.sql')
    end
  end

  # THIS METHOD CHECKS THE REMOVE SERVER FOR SPACE VIA SSH TO REMOTE SERVER
  def ssh_vm_for_space
    $need_space = nil
    Net::SSH.start(@host, @user, :password => @password) do |ssh|
      disk_space = ssh.exec!('df -h / | grep -o "[0-9][0-9]%*"')
      temp = disk_space.to_s
      used_space = temp.gsub("%", "")
      puts "Used disk space is: #{used_space}"
      space = used_space.to_i
      if space == 45
        $need_space = true
      end
    end
    $need_space
  end

  # THIS METHOD USES THE SSH PROTOCOL TO CREATE THE DUMP FILE OF THE POSTGRES DATABASE IN THE REMOTE SERVER
  def ssh_vm_crbackup
    Net::SSH.start(@host, @user, :password => @password) do |ssh|
      ssh.exec!('pg_dump postgres > /home/erick/pg_exemplar.sql')
    end
  end

  # THIS METHOD ENSURES THAT THE REMOTE SERVER IS TOTALLY CLEAN AFTER CREATING, DOWNLOADING AND DELETING THE DUMP FILE.
  def ssh_for_clean
    Net::SSH.start(@host, @user, :password => @password) do |ssh|
      ssh.exec!('sudo apt-get clean')
      ssh.exec!('sudo apt-get autoremove -y')
      ssh.exec!('sudo apt-get autoclean')
    end
  end
end