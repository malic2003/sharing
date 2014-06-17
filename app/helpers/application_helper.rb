module ApplicationHelper

  def errors_for(object)
    messages = object.errors.full_messages.map { |msg| content_tag(:li, '<i class="icon-exclamation-sign"></i>'.html_safe + msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => object.errors.count,
                      :resource => object.class.model_name.human.downcase)

    html = <<-HTML
      <div class="error_explanation alert alert-danger">
        <h2>#{sentence}</h2>
        <ul class='icons'>#{messages}</ul>
      </div>
    HTML
    
    html.html_safe
  end

  def error_messages!(*objects)
    objects.map do |o| 
      resource = instance_variable_get "@#{o}"
      next if resource.errors.empty?
      errors_for resource
    end.compact.join("").html_safe
  end

end
