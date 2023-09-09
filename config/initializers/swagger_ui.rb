# config/initializers/swagger_ui.rb

# Use this initializer to configure Swagger UI.
SwaggerUiEngine.configure do |config|
  config.swagger_url = '/api-docs/swagger.yaml'
  config.doc_expansion = 'list'
end
