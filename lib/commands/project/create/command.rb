module Commands
  module Project
    module Create
      class Command
        attr_reader :payload, :aggregate_id

        def self.build(**args)
          new(**args).tap(&:validate)
        end

        def initialize(params)
          @payload = params.slice(
            "id",
            "title",
            "description",
          )
          @aggregate_id = payload.delete("id")
        end

        def validate
          # raise BadRequest, 'todo_id is blank' if aggregate_id.nil?
          # raise BadRequest, 'title is blank' if payload[:title].nil?
        end
      end
    end
  end
end
