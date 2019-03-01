# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # field :all_links, resolver: Resolvers::LinksSearch
    field :all_links, function: Resolvers::LinksSearch

    # this method is invoked, when `all_link` fields is beeing resolved
    def all_links
      Link.all
    end
  end
end
