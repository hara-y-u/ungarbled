# Ungarbled [![Gem Version](https://badge.fury.io/rb/ungarbled.svg)](http://badge.fury.io/rb/ungarbled) [![Codeship Status for yukihr/ungarbled](https://codeship.io/projects/02d09c20-038a-0132-b307-2245b76790d6/status)](https://codeship.io/projects/30462) [![Coverage Status](https://coveralls.io/repos/yukihr/ungarbled/badge.png)](https://coveralls.io/r/yukihr/ungarbled)

![ungarbled](./readme/readme.png)

`ungarbled` helps to encode multibyte filename correctly for certain platform. Rails integration included. Now only supporting Japanese (If you want another language to be supported, please refer [`Extend Languages`](#extend-languages) section).

## Rails ActionController integration

_Rails >= 4 is supported_

Add below to Gemfile.

```ruby
gem 'ungarbled'
```

Configuration:

```ruby
# config/initializers/ungarbled.rb
Rails.configuration.ungarbled.default_lang = :ja
```

Use `encode_filename` method within Controllers.

```ruby
class FilesController < ApplicationController
  def download
    send_file Rails.root.join('public', 'files', '日本語ファイル名.txt'),
              filename: encode_filename('日本語ファイル名.txt')
    # Use "lang" option to override `default_lang` config
    # encode_filename('日本語ファイル名.txt', lang: :ja)
  end
end
```

To encode Zip item filename, use `encode_filename_for_zip_item`.

```ruby
# Example with rubyzip

directory_to_zip = Rails.root.join('public', 'multibyte_name_files')
zipfile_name = Rails.root.join('tmp', 'multibyte_name_files.zip')

Zip::File.open(, Zip::File::CREATE) do |zipfile|
  Dir[File.join(directory_to_zip, '**', '**')].each do |file|
    zipfile.add(encode_filename_for_zip_item(file.sub(directory_to_zip, '')),
                file
               )
  end
end
```

## Rack Middleware

Rack Middleware parses response and encodes filename automatically.

_This does not encode zip items' filenames_


```ruby
# `config.ru`

use Ungarbled::Middleware, lang: :ja
```

### Rails

```ruby
# config/initializers/ungarbled.rb

Rails.configuration.middleware.use Ungarbled::Middleware, lang: :ja
```

## Extend Languages

`ungarbled` authors are Japanese native, so not sure about other languages. But if you want to ungarble download filenames in your language, please help us extending supporting language. Pull Requests are always welcome!

Please see `lib/ungarbled/encoder/ja.rb` for reference, and just add encoder file in the same directory. You can use [Browser](https://github.com/fnando/browser) instance with `@browser` for browser/platform detection. Test is also required to be added to `test/encoder/yourlanguage_test.rb`

## Future Plan

* Middleware for Zip item
* Automatic Language Detection

## Contributing

1. Fork it
1. Create your feature branch (git checkout -b my-new-feature)
1. Commit your changes (git commit -am 'Added some feature')
1. Push to the branch (git push origin my-new-feature)
1. Create new Pull Request
