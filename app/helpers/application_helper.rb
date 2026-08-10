module ApplicationHelper
  def nav_link_to(name, path, **options)
    active = current_page?(path) || (path == posts_path && controller_name == "posts") || (path == projects_path && controller_name == "projects")
    classes = [ "text-sm font-medium leading-normal transition-colors" ]
    classes << (active ? "text-primary font-bold" : "hover:text-primary")
    classes << options[:class]
    link_to name, path, **options, class: classes.compact
  end

  def admin_nav_class(path)
    active = current_page?(path)
    [ "text-sm font-medium leading-normal transition-colors", active ? "text-primary font-bold" : "text-ink-light hover:text-primary" ].join(" ")
  end

  def admin_input_class
    "w-full rounded-lg border border-edge-light px-3 py-2 text-sm focus:border-primary focus:ring-1 focus:ring-primary focus:outline-none transition-colors"
  end

  def admin_label_class
    "text-sm font-semibold"
  end
end
