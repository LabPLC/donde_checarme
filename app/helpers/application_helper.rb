module ApplicationHelper

  def full_title(page_title)
    base_title = "Checate Aqui"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def google_maps_api_key
    "AIzaSyDj1V1sP3m-NVWvgEAQSqD87949GUit6P0"
  end

  def google_api_url
    "http://maps.googleapis.com/maps/api/js"
  end

  def google_api_access
    "#{google_api_url}?key=#{google_maps_api_key}&libraries=geometry&sensor=true"
  end

  def google_maps_api
    content_tag(:script, :type => "text/javascript", :src => google_api_access ) do
      
    end
  end

  def is_active?(action)
    params[:action] == action ? "active" : nil
  end

end
