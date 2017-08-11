module ApplicationHelper
  def login_helper style=''
    if current_user.is_a?(GuestUser)
      (link_to "Register", new_user_registration_path, class: style) + 
      " ".html_safe +
      (link_to "Log in", new_user_session_path, class: style)  
    else 
      link_to "Logout", destroy_user_session_path, method: :delete, class: style
    end 
  end
  
  def source_helper(styles)
    if session[:source] 
      greeting = "Thanks for visting me from #{session[:source]}, please feel free to #{ link_to 'Contact Me', contact_path }."
      content_tag(:div, greeting.html_safe, class: styles)
    end
  end
  
  def copyright_generator
    LegendViewTool::Renderer.copyright 'Aakash Kulkarni', 'All Rights Reserved'
  end
  
  def nav_items 
    [
      {
        url: root_path, 
        title: 'Home'
      },
      {
        url: about_me_path, 
        title: 'About me'
      },
      {
        url: contact_path, 
        title: 'Contact'
      },
      {
        url: blogs_path, 
        title: 'Blogs'
      },
      {
        url: portfolios_path, 
        title: 'Portfolio'
      },
      {
        url: tech_news_path, 
        title: 'Dev News'
      }
    ]
  end
  
  def nav_helper style, tag_type
    nav_links = ''

    nav_items.each do |item|
      nav_links << "<#{tag_type}><a href='#{item[:url]}' class='#{style} #{active? item[:url]}'>#{item[:title]}</a></#{tag_type}>"
    end

    nav_links.html_safe
  end
  
  def active? path
    "active" if current_page? path
  end
  
  def alerts
    alert = (flash[:alert] || flash[:error] || flash[:notice])

    if alert
      alert_generator alert
    end
  end

  def alert_generator msg
    js add_gritter(msg, title: "Aakash Kulkarni Portfolio", sticky: false)
  end
  
  class CodeRayify < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.scan(code, language).div  
    end
  end
  
  def markdown(text)
    coderayified = CodeRayify.new(first_html: true, hard_wrap: true)
    
    options = {
      fenced_code_blocks: true,
      no_intra_emphasis: true,
      auto_links: true,
      lax_html_blocks: true,
    }
    
    markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
    markdown_to_html.render(text).html_safe
  end
end
