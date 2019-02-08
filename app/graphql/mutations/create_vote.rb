module Mutations
  class CreateVote < BaseMutation
    argument :link_id, ID, required: false

    type Types::VoteType

    def resolve(link_id: nil)
      Vote.create!(
        # # invalid base64 when using query from tutorial
        # link: RailsGraphqlExampleSchema.object_from_id(link_id, context),
        link: Link.find(link_id),
        user: context[:current_user]
      )
    end
  end
end
