# config/initializers/swagger_ui.rb

SwaggerUiEngine.configure do |config|
  config.swagger_url = '/api-docs/swagger.yaml'
  config.doc_expansion = 'list'
end
