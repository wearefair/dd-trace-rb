require 'ddtrace/contrib/rails/framework'
require 'ddtrace/contrib/rails/middlewares'
require 'ddtrace/contrib/rack/middlewares'

module Datadog
  # Railtie class initializes
  class Railtie < Rails::Railtie
    # Add the trace middleware to the application stack
    initializer 'datadog.add_middleware' do |app|
      app.middleware.insert_before(0, Datadog::Contrib::Rack::TraceMiddleware)
      # Insert right after Rails exception handling middleware, because if it's before,
      # it catches and swallows the error. If it's too far after, custom middleware can find itself
      # between, and raise exceptions that don't end up getting tagged on the request properly (e.g lost stack trace.)
      app.middleware.insert_after(ActionDispatch::ShowExceptions, Datadog::Contrib::Rails::ExceptionMiddleware)
    end

    config.after_initialize do
      Datadog::Contrib::Rails::Framework.setup
      Datadog::Contrib::Rails::ActionController.instrument
      Datadog::Contrib::Rails::ActionView.instrument
      Datadog::Contrib::Rails::ActiveSupport.instrument
    end
  end
end
