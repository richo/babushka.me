worker_processes 4
working_directory '.'

preload_app true
timeout 60

listen "/srv/http/babushka.me/current/tmp/sockets/unicorn.socket", :backlog => 64
pid "/srv/http/babushka.me/current/tmp/pids/unicorn.pid"
stderr_path "/srv/http/babushka.me/current/log/unicorn.stderr.log"
stdout_path "/srv/http/babushka.me/current/log/unicorn.stdout.log"

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!

  `cat #{server.pid}.oldbin`.scan(/^\d+$/).each {|ppid|
    `kill -QUIT #{ppid}`
  }
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end
