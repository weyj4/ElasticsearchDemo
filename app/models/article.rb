require 'elasticsearch/model'

class Article < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
end

Article.import

# Q to consider - What does it mean for the article to be auto synced w/ Elasticsearch?
# does this mean that SQL and Elasticsearch talk to each other?

def self.search(query)
  __elasticsearch__.search(
    {
      query: {
        multi_match: {
        	query: query,
        	fields: ['title^10', 'text']
        }
      }
    }
)
end