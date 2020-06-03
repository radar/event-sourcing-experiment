require "events/project/created"

module Aggregates
  class Project
    include EventSourcery::AggregateRoot

    # These apply methods are the hook that this aggregate uses to update
    # its internal state from events.

    apply ProjectCreated do |event|
      # We track the ID when a project is added so we can ensure the same project isn't
      # added twice.
      #
      # We can save more attributes off the event in here as necessary.
      @aggregate_id = event.aggregate_id
    end

    def add(payload)
      raise UnprocessableEntity, "Project #{id.inspect} already exists" if created?

      apply_event(ProjectCreated,
        aggregate_id: id,
        body: payload,
      )
    end

    private

    def created?
      @aggregate_id
    end
  end
end
