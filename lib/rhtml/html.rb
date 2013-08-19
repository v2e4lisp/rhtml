module Rhtml
  class Html
    def initialize(content='', indent=0, &b)
      @__indent = indent
      @__content = content
      @__ps = {}
      instance_eval(&b) if block_given?
    end

    def tag!(tag_name, ps={}, str=nil,  &b)
      str, ps = ps, {} if ps.is_a? String
      # merge the default (@__ps) to current properties except for class.
      # the default class will be append to current classes
      ps[:class] << " #{@__ps[:class]}"  if @__ps[:class] and ps[:class]
      ps = @__ps.merge ps
      @__ps.clear
      @__content << Tag.tag_open(tag_name, ps, @__indent)

      @__indent += 1
      if str
        @__content << INDENT * @__indent << str << "\n"
      elsif block_given?
        ret = instance_eval &b
        @__content << INDENT * @__indent << ret.to_s << "\n" if ret.is_a?(String)
      end
      @__indent -= 1

      @__content << Tag.tag_close(tag_name, @__indent)
      self
    end

    def void_tag!(tag_name, ps={})
      @__content << Tag.void_tag(tag_name, ps, @__indent)
      self
    end

    Tag::TAGS.each do |m|
      if Tag::VOID_TAGS.include? m
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
      @__content << string.to_s << "\n" and nil
    end
    alias_method :==, :raw!

    def to_s
      @__content
    end
  end
end
