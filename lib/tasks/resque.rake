
require 'resque/scheduler/tasks'

namespace :resque do
  desc "let resque workers always load the rails environment"
  task setup: :environment do
    require 'resque'
    require 'resque-scheduler'
    require 'resque/scheduler'
    Resque::Scheduler.dynamic = true
    Resque.schedule = YAML.load_file( File.join(Rails.root, 'config', 'resque_schedule.yml') ) || {}
  end

  desc "kill all workers (using -QUIT), god will take care of starting them again"
  task stop_workers: :environment do
    pids = Array.new

    Resque.workers.each do |worker|
      pids << worker.to_s.split(/:/).second
    end

    if pids.size > 0
      system("kill -QUIT #{pids.join(' ')}")
    end

    # let's not remove the pid files, god should handle the restart
    #system("rm /var/run/god/resque-1.8.0*.pid")
  end


  desc "kill all resque schedule workers (using -QUIT), god will take care of starting them again"
  task stop_scheduler: :environment do
    # kind of dirty trick to really kill the scheduler:
    # https://github.com/bvandenbos/resque-scheduler/issues/205
    pidfile       = File.join(Rails.root, "tmp/pids/resque_scheduler.pid")
    exit_timeout  = 10
    if !File.exists?(pidfile)
      puts "Scheduler not running"
    else
      pid = File.read(pidfile).to_i

      puts "Running syscmd: kill -s TERM #{pid}"
      system("kill -s TERM #{pid}")

      sleep(exit_timeout)

      if `ps -o state= -p #{pid}`.gsub(/\s/,'')
        puts "Running syscmd: kill -s KILL #{pid}"
        system("kill -s KILL #{pid}")
      end
      FileUtils.rm_f(pidfile)
    end
  end

end