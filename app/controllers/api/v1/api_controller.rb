class Api::V1::ApiController < ActionController::API
  rescue_from StandardError, with: :render_standard_error
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private

  def render_not_found
    render status: 404, json: '{ "error": "Objeto não encontrado" }'
  end

  def render_standard_error
    render status: 500, json: '{ "error": "Erro interno" }'
  end
end
