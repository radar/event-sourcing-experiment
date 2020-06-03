require "commands/project/create/command"
require "commands/project/create/command_handler"

class ProjectsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    command = Commands::Project::Create::Command.build(**params.except(:controller, :action).permit!.to_h)
    Commands::Project::Create::CommandHandler.new.handle(command)
    head 201
  end
end
