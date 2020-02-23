# Variant

Provides a model for application variants, including documenting behaviour like `RACK_ENV` and `APP_ENV`.

[![Development](https://github.com/socketry/variant/workflows/Development/badge.svg?branch=master)](https://github.com/socketry/variant/actions?workflow=Development)

## Installation

```
bundle add variant
```

## Usage

The general mechanism for specifying a variant is on the command line before running the application:

```
VARIANT=production falcon serve
```

In your code, you access this like so:

```ruby
Variant.default # => :production
Variant.for(:database) # => :production
```

### Defaults

The default variant is `:development`.

### System-specific Variants

```
VARIANT=production DATABASE_VARIANT=production-aws
```

In your code, you access this like so:

```ruby
Variant.default # => :production
Variant.for(:database) # => :'production-aws'
```

If you don't specify a system-specific variant, you will get the default.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Released under the MIT license.

Copyright, 2020, by [Samuel G. D. Williams](https://www.codeotaku.com).

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
