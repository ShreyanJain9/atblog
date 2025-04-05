require "sinatra"
require "sinatra/contrib"

require "haml"
require "kramdown"
require_relative "extra/helpers"
ENV["LUA_LIB"] = abs_path("./liblua.dylib")
require_relative "app/env"
require_relative "atproto/blog"

MainBlog = AtBlog::Blog.new(AtBlog::Config)

get "/" do
  page = params[:page]
  backbutton = page != nil
  data = MainBlog.post_list(page)
  cursor = data[:cursor]
  posts = data[:records]
  haml :index, locals: { cursor: cursor, posts: posts, backbutton: backbutton }
end

get "/post/:post_id" do
  post = MainBlog.get_post(params[:post_id])
  haml :post, locals: { post_content: post["value"] }
end

Sinatra::Application.run
