module ApplicationHelper
  def nav_link_to(name, path, **options)
    active = current_page?(path) || (path == posts_path && controller_name == "posts") || (path == projects_path && controller_name == "projects")
    classes = [ "text-sm font-medium leading-normal transition-colors" ]
    classes << (active ? "text-primary font-bold" : "hover:text-primary")
    classes << options[:class]
    link_to name, path, **options, class: classes.compact
  end
end
