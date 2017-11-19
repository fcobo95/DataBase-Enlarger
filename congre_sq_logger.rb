require 'pg'
require 'net/ssh'
class CongreSQLogger
  $connection_string = PG::Connection.open(:host => '192.168.56.105', :dbname => 'postgres',
                                           :user => 'postgres', :password => 'viper1829')

  $connection_string.exec('CREATE TABLE HOLAS(id serial primary key)')

rescue PG::Error => the_error_message
  puts the_error_message.message
end

