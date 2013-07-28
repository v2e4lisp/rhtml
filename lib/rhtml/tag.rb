module Rhtml
  def Rhtml.properties ps
    ps.map { |p| "#{p[0].to_s.gsub("_", "-")}='#{p[1].to_s}'" }.join(' ')
  end

  def Rhtml.tag_open tag_name, ps={}
    if ps.empty?
      "#{INDENT * indent}<#{tag_name}>\n"
    else
      "#{INDENT * indent}<#{tag_name} #{properties ps}>\n"
    end
  end

  def Rhtml.tag_close tag_name
    "#{INDENT * indent}</#{tag_name}>\n"
  end
end
