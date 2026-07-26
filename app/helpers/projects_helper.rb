module ProjectsHelper
  def project_icon(project)
    case project.slug
    when /scoutspin/i then "sports_tennis"
    when /buildcue/i  then "construction"
    when /youtube/i   then "smart_display"
    when /history/i   then "menu_book"
    else "widgets"
    end
  end
end
