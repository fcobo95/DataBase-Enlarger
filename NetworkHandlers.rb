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

  def scp_host_for_backupdl
    Net::SSH.start(@host, @user, :password => @password) do |ssh|
      ssh.exec!('scp /home/erick/pg_postgres_dump_exemplar.sql ecobo95@192.168.1.9:/home/ecobo95/')
    end #DO ENDS
  end

  def sftp_to_vm_rmbackup
    Net::SFTP.start(@host, @user, :password => @password) do |sftp|
      sftp.remove!('/home/erick/pg_postgres_dump_exemplar.sql')
    end
  end

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

  def ssh_vm_crbackup
    Net::SSH.start(@host, @user, :password => @password) do |ssh|
      ssh.exec!('pg_dump postgres > /home/erick/pg_postgres_dump_exemplar.sql')
    end
  end

  def ssh_for_clean
    Net::SSH.start(@host, @user, :password => @password) do |ssh|
      ssh.exec!('sudo apt-get clean')
      ssh.exec!('sudo apt-get autoremove -y')
      ssh.exec!('sudo apt-get autoclean')
    end
  end
end