Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3000', 'http://localhost:5173' # Allow frontend domains (you can add multiple origins)

    resource '*',
      headers: :any, # Allow all headers
      methods: [:get, :post, :options, :put, :patch], # Allowed HTTP methods
      credentials: true # Enable cookies, authorization headers, or TLS client certificates
  end
end
