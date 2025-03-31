require "sinatra"

require "haml"
require_relative "extra/helpers"
ENV["LUA_LIB"] = abs_path("./liblua.dylib")
require_relative "app/env"
require_relative "atproto/blog"

MainBlog = AtBlog::Blog.new(AtBlog::Config)

get "/" do
  MainBlog.post_list.to_json
end

Sinatra::Application.run
