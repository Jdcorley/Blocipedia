module ApplicationHelper
  def form_group_tag(errors, &block)
    css_class = 'form-group'
    css_class << ' has-error' if errors.any?

    content_tag :div, capture(&block), class: css_class
  end

   def markdown(text)
    render = Redcarpet::Render::HTML.new(filter_html: true) 
    options = { hard_wrap: true, 
                autolink: true, 
                filter_html: true, 
                no_intraemphasis: true,
                fenced_code: true,
                gh_blockcode: true }
    Redcarpet::Markdown.new(render, options).render(text).html_safe
  end 
end
