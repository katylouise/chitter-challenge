require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'
require './data_mapper_setup'
require './app/helpers/app_helpers'
require './app/controllers/base_controller.rb'
require './app/controllers/home_controller.rb'
require './app/controllers/peep_controller.rb'
require './app/controllers/session_controller.rb'
require './app/controllers/user_controller.rb'
# Dir["./app/controllers/*.rb"].each {|file| require file }


include TheApp::Models

module TheApp

  class Chitter < Sinatra::Base

    include AppHelpers
    register Sinatra::Flash
    register Sinatra::Partial

    use Routes::UserController
    use Routes::SessionController
    use Routes::PeepController
    use Routes::HomeController

  end

end
