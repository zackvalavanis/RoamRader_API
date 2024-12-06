Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # Allow all origins

    resource '*', 
      headers: :any, # Allow all headers
      methods: [:get, :post, :options, :put, :patch], # Allowed HTTP methods
      credentials: false # Enable cookies, authorization headers, or TLS client certificates
  end
end
