# frozen_string_literal: true

class RailsGraphqlExampleSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  def self.resolve_type(_type, object, _ctx)
    type_class = "::Types::#{object.class}Type".safe_constantize

    unless type_class.present?
      raise ArgumentError, "Cannot resolve type for class #{object.class.name}"
    end

    type_class
  end

  def self.object_from_id(node_id, _ctx)
    return unless node_id.present?

    # invalid base64 when using query from tutorial
    record_class_name, record_id = GraphQL::Schema::UniqueWithinType.decode(node_id)

    record_class = record_class_name.safe_constantize
    record_class&.find_by id: record_id
  end

  def self.id_from_object(object, _type, _ctx)
    GraphQL::Schema::UniqueWithinType.encode(object.class.name, object.id)
  end
end
