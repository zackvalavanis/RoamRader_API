# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Specify the allowed origins (replace '*' with the actual domain you want to allow, like 'http://localhost:3000' or 'https://yourfrontend.com')
    origins '*' # You can specify individual domains here for better security
    
    resource '*',
      headers: :any,  # Allows all headers
      methods: [:get, :post, :options, :put, :patch, :delete],  # Allowed HTTP methods (Added DELETE if needed)
      credentials: false  # Set to true if you need to allow cookies, authorization headers, or TLS client certificates
  end
end
