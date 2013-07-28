module Rhtml
  def Rhtml.html!(&b)
    Rhtml::Html.new.html(&b)
  end
end
