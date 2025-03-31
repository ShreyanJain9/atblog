require "minisky"

class AtBlog::Blog
  def initialize(config)
    @client = Minisky.new(config.pds, nil)
    @config = config
  end

  attr_reader :config, :client

  def post_list
    # for now just the last 200 posts
    # TODO: pagination
    posts = @client.fetch_all(
      "com.atproto.repo.listRecords",
      { repo: @config.repo, collection: @config.post_collection },
      field: "records",
      max_pages: 2,
    )
  end
end
