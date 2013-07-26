class Html
  attr_accessor :content, :indent

  INDENT = '  '
  VOID_TAGS = %w{area base br col command embed hr img input keygen link meta param source track wbr}

  def initialize(content='', indent=0, &b)
    @indent = 0
    @content = content
    @content << instance_eval(&b) if block_given?
  end

  def method_missing(tag_name, ps={}, str=nil,  &b)

    if ps.is_a? String
      str, ps = ps, {}
    end

    tag_name = tag_name.to_s
    if VOID_TAGS.include? tag_name
      content << void_tag(tag_name, ps)
    else
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
    end

    self
  end

  # conflict with global p method
  def p(ps={}, &b)
    method_missing("p", ps, nil, &b)
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

  def void_tag tag_name, ps={}
    "#{INDENT * indent}<#{tag_name} #{properties ps}/>\n"
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
