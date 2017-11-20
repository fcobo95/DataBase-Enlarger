require 'net/ssh'
require 'net/scp'
require 'net/sftp'
class NetworkHandlers

  # THIS IS THE NETWORKHANDLERS CONSTRUCTOR OR INITIALIZER METHOD
  # PARAMETERS ARE
  # HOST=> IT'S THE IP OF THE VIRTUAL MACHINE TO MONITOR
  # USER=> IT'S THE VM USER TO CONNECT AS
  # PASSWORD=> IT'S THE USER'S PASSWORD

  # CONSTRUCTOR BEGINS

  def initialize(host, user, password)
    @host = host
    @user = user
    @password = password
  end

  # CONSTRUCTOR ENDS

  # DEF SCP_HOST BEGINS

  # THIS METHOD IS SUPPOSED TO HANDLE THE DOWNLOAD OF THE POSTGRE_DUMP FILE IN THE REMOTE SERVER(VM)
  def scp_host
    Net::SCP.start(@host, @user, :password => @password) do |scp|
      scp.download "/home/erick/postgres_dump.sql", "/home/ecobo95/PostgresDumps/"
    end #DO ENDS
  end

  # DEF ENDS

  # DEF SSH_VM BEGINS

  # THIS METHOD WORKS TO CHECK FOR REMOTE SERVER(VM) FOR DISK SPACE USING SSH.EXEC!
  def ssh_vm
    Net::SSH.start(@host, @user, :password => @password) do |ssh|
      while true
        disk_space = ssh.exec!("df -h / | grep -o '[0-9][0-9]%*'")
        temp = disk_space.to_s
        used_space = temp.gsub("%", "")
        puts "Used disk space is: #{used_space}"
        space = used_space.to_i
        if space == 41
          ssh.exec!('pg_dump postgres > postgres_dump.sql')
          scp_host
          sftp_to_vm
        end # IF ENDS
      end
    end # DO ENDS
  end

  # DEF ENDS

  # DEF SFTP_TO_VM STARTS

  # THIS METHOD WORKS TO CHECK THE REMOTE DIRECTORY AND ERASE THE POSTGRES_DUMP FILE
  def sftp_to_vm
    Net::SFTP.start(@host, @user, :password => @password) do |sftp|
      sftp.remove("/home/erick/postgres_dump.sql")
    end # DO ENDS
  end
  # DEF ENDS

end #CLASS ENDS