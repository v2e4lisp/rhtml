module Rhtml
  class Html
    def initialize(content='', indent=0, &b)
      @indent = 0
      @content = content
      @content << instance_eval(&b) if block_given?
    end

    def tag!(tag_name, ps={}, str=nil,  &b)
      str, ps = ps, {} if ps.is_a? String
      @content << Rhtml.tag_open(tag_name, ps, @indent)
      @indent += 1
      if str
        @content << INDENT * @indent << str << "\n"
      elsif block_given?
        ret = instance_eval &b
        @content << INDENT * @indent << ret.to_s << "\n" if ret.is_a?(String)
      end
      @indent -= 1
      @content << Rhtml.tag_close(tag_name, @indent)
      self
    end

    def void_tag!(tag_name, ps={})
      @content << Rhtml.void_tag(tag_name, ps, @indent)
      self
    end

    TAGS.each do |m|
      if VOID_TAGS.include? m
        define_method(m.to_sym) do |ps={}|
          void_tag!(m, ps)
        end
      else
        define_method(m.to_sym) do |ps={}, str=nil, &b|
          tag!(m, ps, str, &b)
        end
      end
    end

    def raw! string=''
      @content << string.to_s << "\n"
    end

    def to_s
      @content
    end
  end
end
