require 'aggregates/project'

module Commands
  module Project
    module Create
      class CommandHandler
        def initialize(repository: Rails.application.repository)
          @repository = repository
        end

        # Handle loads the aggregate state from the store using the repository,
        # defers to the aggregate to execute the command, and saves off any newly
        # raised events to the store.
        def handle(command)
          binding.pry
          aggregate = repository.load(Aggregates::Project, command.aggregate_id)
          aggregate.add(command.payload)
          repository.save(aggregate)
        end

        private

        attr_reader :repository
      end
    end
  end
end
