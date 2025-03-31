require "rufus-lua"
require "ostruct"

module AtBlog
end

config = Rufus::Lua::State.new
at_config_hash = config.eval(File.read(abs_path("../config.lua"))).to_h

AtBlog::Config = OpenStruct.new(at_config_hash)
