# Rhtml

A DSL to write html in pure ruby.
**write test tomorror**

## Installation

Add this line to your application's Gemfile:

    gem 'rhtml'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rhtml

## Usage

```ruby
html! {
  body {
    div(class: "post", id: 1) {
      title "first post"
      br
      p "hello world"
      div(class: "comment") {
        p(class: "grey") {
          "No comments yet."
        }
      }
    }
  }
}
```
** converted to html **

```html
<html>
  <body>
    <div class='post' id='1'>
      <title>
first post
      </title>
      <br />
      <p>
hello world
      </p>
      <div class='comment'>
        <p class='grey'>
No comments yet.
        </p>
      </div>
    </div>
  </body>
</html>
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
