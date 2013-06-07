module ApplicationHelper
  def body_class
    "#{controller.controller_path} #{controller.controller_path}_#{controller.action_name}"
  end
end
