class Html
  attr_accessor :content, :indent

  INDENT = '  '
  VOID_TAGS = %w{area base br col command embed hr img input keygen link meta param source track wbr}
  TAGS = %w{a abbr acronym address applet area article aside audio b base basefont bdi
bdo big blockquote body br canvas caption center cite code col colgroup command
datalist dd del details dfn dialog dir div dl dt em embed fieldset figcaption
figure font footer form frame frameset h1 head header hgroup hr html i iframe
img input ins kbd keygen label legend li link map mark menu meta meter nav noframes
noscript object ol optgroup option output p param pre progress q rp rt ruby s samp
script section select small source span strike strong style sub summary sup table tbody
td textarea tfoot th thead time title tr track tt u ul var video wbr}

  def initialize(content='', indent=0, &b)
    @indent = 0
    @content = content
    @content << instance_eval(&b) if block_given?
  end

  def tag(tag_name, ps={}, str=nil,  &b)
    str, ps = ps, {} if ps.is_a? String
    content << tag_open(tag_name, ps)
    @indent += 1
    if str
      content << str << "\n"
    elsif block_given?
      ret = instance_eval &b
      content << ret.to_s << "\n" unless ret.is_a?(self.class)
    end
    @indent -= 1
    self.content << tag_close(tag_name)
    self
  end

  def void_tag(tag_name, ps={})
    content <<  "#{INDENT * indent}<#{tag_name} #{properties ps}/>\n"
    self
  end

  TAGS.each do |m|
    if VOID_TAGS.include? m
      define_method(m.to_sym) do |ps={}|
        void_tag(m, ps)
      end
    else
      define_method(m.to_sym) do |ps={}, str=nil, &b|
        tag(m, ps, str, &b)
      end
    end
  end

  def properties ps
    ps.map { |p| "#{p[0].to_s.gsub("_", "-")}='#{p[1].to_s}'" }.join(' ')
  end

  def tag_open tag_name, ps={}
    if ps.empty?
      "#{INDENT * indent}<#{tag_name}>\n"
    else
      "#{INDENT * indent}<#{tag_name} #{properties ps}>\n"
    end
  end

  def tag_close tag_name
    "#{INDENT * indent}</#{tag_name}>\n"
  end

  def raw string=''
    @content << string.to_s << "\n"
  end

  def to_s
    content
  end
end

def html!(&b)
  Html.new.html(&b)
end
