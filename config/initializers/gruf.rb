require 'gruf'
require 'core_services_pb'

Gruf.configure do |c|
  c.server_binding_url = 'localhost:50051'
  c.backtrace_on_error = !Rails.env.production?

  c.interceptors.use(Gruf::Interceptors::Instrumentation::RequestLogging::Interceptor, formatter: :logstash)

  # if Settings.grpc.server.tokens.to_s.present?
  #   c.interceptors.use(
  #     Gruf::Interceptors::Authentication::Basic,
  #     credentials: Settings.grpc.server.tokens.to_s.split(',').map { |t| { password: t.strip } }
  #   )
  # end
end
