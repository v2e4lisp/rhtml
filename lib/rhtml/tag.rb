module Rhtml

  INDENT = '  '

  module Tag
    extend self
    VOID_TAGS = %w{area base br col command embed hr img input keygen link meta param source track wbr}

    TAGS = %w{a abbr acronym address applet area article aside audio b base basefont bdi
bdo big blockquote body br canvas caption center cite code col colgroup command
datalist dd del details dfn dialog dir div dl dt em embed fieldset figcaption
figure font footer form frame frameset h1 head header hgroup hr html i iframe
img input ins kbd keygen label legend li link map mark menu meta meter nav noframes
noscript object ol optgroup option output p param pre progress q rp rt ruby s samp
script section select small source span strike strong style sub summary sup table tbody
td textarea tfoot th thead time title tr track tt u ul var video wbr}

    def properties ps
      ps.map { |p| "#{p[0].to_s.gsub("_", "-")}='#{p[1].to_s}'" }.join(' ')
    end

    def void_tag tag_name, ps={}, indent
      "#{INDENT * indent}<#{tag_name}#{' ' << properties(ps) unless ps.empty?}/>\n"
    end

    def tag_open tag_name, ps={}, indent
      "#{INDENT * indent}<#{tag_name}#{' ' << properties(ps) unless ps.empty?}>\n"
    end

    def tag_close tag_name, indent
      "#{INDENT * indent}</#{tag_name}>\n"
    end
  end
end
