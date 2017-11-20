require 'net/ssh'
require 'net/scp'
require 'net/sftp'
class NetworkHandlers

  def initialize(host, user, password)
    @host = host
    @user = user
    @password = password
  end

  # CONSTRUCTOR ENDS

  def scp_host
    Net::SCP.start(@host, @user, :password => @password) do |scp|
      scp.download "/home/erick/postgres_dump.sql", "/home/ecobo95/PostgresDumps"
    end #DO ENDS
  end

  # DEF ENDS

  # THIS METHOD WORKS TO CHECK FOR VM DISK SPACE
  def ssh_vm
    Net::SSH.start(@host, @user, :password => @password) do |ssh|
      while true
        disk_space = ssh.exec!("df -h / | grep -o '[0-9][0-9]%*'")
        temp = disk_space.to_s
        used_space = temp.gsub("%", "")
        puts "Used disk space is: #{used_space}"
        space = used_space.to_i
        if space == 50
          ssh.exec!('pg_dump postgres > postgres_dump.sql')
          scp_host
          sftp_to_vm
        end # IF ENDS
      end
    end # DO ENDS
  end

  #DEF ENDS

  def sftp_to_vm
    Net::SFTP.start(@host, @user, :password => @password) do |sftp|
      sftp.remove('/home/erick/postgres_dump.sql')
    end # DO ENDS
  end #DEF ENDS
end #CLASS ENDS