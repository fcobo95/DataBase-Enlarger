require_relative 'NetworkHandlers'
class Main
  host = '192.168.1.5'
  user = 'erick'
  password = 'root'

  # HANDLERS IS THE NEW NETWORKHANDLERS OBJECT USED TO ACCESS DAEMON FUNCTIONALITY TO MONITOR DISK SPACE
  # AND TO ACT WHEN THE DB IS GROWING FRANTICALLY.
  handlers = NetworkHandlers.new(host, user, password)
  handlers.ssh_vm
end