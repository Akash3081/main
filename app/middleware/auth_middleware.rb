class AuthMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    if request.path.start_with?('/api')
      token = request.env['HTTP_AUTHORIZATION']&.split(' ')&.last
      user_id = JsonWebToken.decode(token)['user_id'] if token
      env['user_id'] = user_id
    end
    @app.call(env)
  end
end
