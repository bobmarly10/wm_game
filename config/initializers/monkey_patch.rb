# redis/redis-rb monkey patch for automatically reconnecting to server
# see: https://github.com/redis/redis-rb/pull/389
class Redis
  class Client
    def ensure_connected
      tries = 0

      begin
        if connected?
          if Process.pid != @pid
            if @reconnect
              reconnect
            else
              raise InheritedError,
                "Tried to use a connection from a child process without reconnecting. " +
                "You need to reconnect to Redis after forking."
            end
          end
        else
          connect
        end

        tries += 1

        yield
      rescue ConnectionError
        disconnect

        if tries < 2 && @reconnect
          retry
        else
          raise
        end
      rescue Exception
        disconnect
        raise
      end
    end
  end
end