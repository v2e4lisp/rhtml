module Rhtml
  class Html
    def initialize(content='', indent=0, &b)
      @__indent = 0
      @__content = content
      @__cls = nil
      @__id = nil
      instance_eval(&b) if block_given?
    end

    def tag!(tag_name, ps={}, str=nil,  &b)
      str, ps = ps, {} if ps.is_a? String
      ps[:class] = @__cls if @__cls
      ps[:id] = @__id if @__id

      @__content << Rhtml.tag_open(tag_name, ps, @__indent)
      @__cls = @__id = nil

      @__indent += 1
      if str
        @__content << INDENT * @__indent << str << "\n"
      elsif block_given?
        ret = instance_eval &b
        @__content << INDENT * @__indent << ret.to_s << "\n" if ret.is_a?(String)
      end
      @__indent -= 1

      @__content << Rhtml.tag_close(tag_name, @__indent)
      self
    end

    def void_tag!(tag_name, ps={})
      @__content << Rhtml.void_tag(tag_name, ps, @__indent)
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
      @__content << string.to_s << "\n"
    end
    alias_method :==, :raw!

    def to_s
      @__content
    end
  end
end
