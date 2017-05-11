module ResponseHelpers
  def error!(err, status = 500)
    render json: { error: { type: err.class.name, message: err.message } }, status: status
  end

  def invalid_params!(err, status = 422)
    error!(err, status)
  end

  def not_found!(err, status = 404)
    error!(err, status)
  end

  def success!(payload, status = 200)
    render json: payload, status: status
  end

  def created!(payload, status = 201)
    render json: payload, status: status
  end
end