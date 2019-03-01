# frozen_string_literal: true

require "search_object/plugin/graphql"

module Resolvers
  class LinksSearch < Base
    # include SearchObject for GraphQL
    include SearchObject.module(:graphql)

    # scope is starting point for search
    scope { Link.all }

    type types[Types::LinkType]

    # inline input type definition for the advance filter
    class LinkFilter < ::Types::BaseInputObject
      argument :OR, [self], required: false
      argument :description_contains, String, required: false
      argument :url_contains, String, required: false
    end

    # when "filter" is passed "apply_filter" would be called to narrow the scope
    option :filter, type: LinkFilter, with: :apply_filter
    option :first, type: types.Int, with: :apply_first
    option :skip, type: types.Int, with: :apply_skip

    def apply_first(scope, value)
      scope.limit(value)
    end

    def apply_skip(scope, value)
      scope.offset(value)
    end

    # apply_filter recursively loops through "OR" branches
    def apply_filter(scope, value)
      branches = normalize_filters(value).reduce { |a, b| a.or(b) }
      scope.merge(branches)
    end

    def normalize_filters(value, branches = [])
      scope = Link.all
      description = value["description_contains"]
      url = value["url_contains"]

      scope = scope.like(:description, description) if description
      scope = scope.like(:url, url) if url

      branches << scope

      if value["OR"].present?
        value["OR"].reduce(branches) do |s, v|
          normalize_filters(v, s)
        end
      end

      branches
    end
  end
end
