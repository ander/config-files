require 'logger'
Object.const_set(:RAILS_DEFAULT_LOGGER, Logger.new(STDOUT))

def connection
  ActiveRecord::Base.connection
end

def sql(query)
  connection.select_all(query)
end

# this is for tables which don't have a model
def fields(table_name)
  f_arr = connection.select_all("SHOW FIELDS FROM #{table_name}").\
    map{|f| f['Field']}
  f_arr.sort!
  puts f_arr.to_yaml
end

### logging
def loud_logger
  set_logger_to Logger.new(STDOUT)
end

def quiet_logger
  set_logger_to nil
end

def set_logger_to(logger)
  ActiveRecord::Base.logger = logger
  ActiveRecord::Base.clear_active_connections!
end

### Machinist blueprints
def bp
  require 'machinist'
  require File.join(RAILS_ROOT, 'spec', 'blueprint')
end