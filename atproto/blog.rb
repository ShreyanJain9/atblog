require "minisky"

class AtBlog::Blog
  def initialize(config)
    @client = Minisky.new(config.pds, nil)
    @config = config
  end

  def home_rec
    @home_rec ||= @client.get_request("com.atproto.repo.getRecord", { repo: @config.repo, collection: @config.homepage_record, rkey: "self" })["value"]
  end

  attr_reader :config, :client

  def post_list(page = nil)
    # for now just the last 200 posts
    # TODO: pagination
    stuff = @client.get_request(
      "com.atproto.repo.listRecords",
      { repo: @config.repo, collection: @config.post_collection, cursor: page, limit: 100 },
    )

    return {
             records: stuff["records"],
             cursor: stuff["cursor"],
           }
  end

  def get_post(post_id)
    @client.get_request("com.atproto.repo.getRecord", { repo: @config.repo, collection: @config.post_collection, rkey: post_id })
  end
end

def at_link_to_real_url(link)
  uri_bits = link.split("/")
  rkey = uri_bits.last
  "/post/#{rkey}"
end

def get_formatting_type(lex)
  if lex.start_with?(MainBlog.config.formatting_lex)
    lex.split("#")[1]
  else
    raise "Formatting lexicon not recognized: #{lex}"
  end
end

def get_block_type(lex)
  if lex.start_with?(MainBlog.config.block_lex)
    lex.split("#")[1]
  else
    raise "Block lexicon not recognized: #{lex}"
  end
end

def render_section(text)
  text
end
