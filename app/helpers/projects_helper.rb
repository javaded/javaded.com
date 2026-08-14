module ProjectsHelper
  def project_icon(project)
    case project.slug
    when /scoutspin/i then "sports_tennis"
    when /spinyard/i  then "query_stats"
    when /venonwood/i then "factory"
    when /dropball/i  then "sports_soccer"
    when /buildcue/i  then "construction"
    else "widgets"
    end
  end
end
