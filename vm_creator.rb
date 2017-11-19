#!/usr/bin/ruby

class VmCreator

  puts "Enter the amount of VM's to create: "
  puts "A default main node will be created as well."
  puts "Creating new VM's................."

  puts "Creating Main Server Node............"
  system "VBoxManage clonevm 'Ubuntu Server Template' --name 'Ubuntu Server Main Node' --register"
  system "VBoxManage startvm 'Ubuntu Server Main Node'"
  sleep(50)


  begin

    if (vm_number.to_i - 1) == 0
      puts "Previous VM was Ubuntu Server Main Node"
      puts "Previous VM was VM Ubuntu Server Node".int($vm_number - 1)
      system "VBoxManage clonevm 'Ubuntu Server Template' --name 'Ubuntu Server Node $vm_number' --register"
      puts "Creating next VM...."

      if vm_number > 5
        system "VBoxManage startvm 'Ubuntu Server Node $vm_number' --type headless"


      else
        system "VBoxManage startvm 'Ubuntu Server Node $vm_number'"


        puts "$vm_number"

      end
    end
  end while vm_number
end

