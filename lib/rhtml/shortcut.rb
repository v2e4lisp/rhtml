module Rhtml
  def html!(&b)
    Rhtml::Html.new.html(&b)
  end
end
