require "./config/environment"

use Rack::MethodOverride

use UsersController #all the child controllers use use
use SessionsController
use MoviesController
run ApplicationController #run is only used once for the parent controller