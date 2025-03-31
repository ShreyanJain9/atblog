def abs_path(path)
  caller_path = File.dirname(caller_locations(1, 1)[0].absolute_path)
  File.expand_path(path, caller_path)
end
