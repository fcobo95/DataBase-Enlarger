require 'net/scp'
class SendSCPToHost
  def initialize(theHost, theUser, thePassword)
    @theHostAddr = theHost
    @theUser = theUser
    @theUserPass = thePassword
  end

  Net::SCP.start(@theHostAddr, @theUser, :password => @theUserPass) do |scp|
    # synchronous (blocking) upload; call blocks until upload completes
    scp.download "/home/erick/pg_dump.sql", "/home/ecobo95/Documents"

  end
end