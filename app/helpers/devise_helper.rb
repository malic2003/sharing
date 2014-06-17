module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?
    errors_for resource
  end
end