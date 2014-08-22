# Ungarbled [![Codeship Status for yukihr/ungarbled](https://codeship.io/projects/02d09c20-038a-0132-b307-2245b76790d6/status)](https://codeship.io/projects/30462) [![Dependency Status](https://gemnasium.com/yukihr/ungarbled.svg)](https://gemnasium.com/yukihr/ungarbled) [![Gem Version](https://badge.fury.io/rb/ungarbled.svg)](http://badge.fury.io/rb/ungarbled)

![ungarbled](./readme/readme.png)

`ungarbled` encodes multibyte filename correctly for certain platform. Rails integration included.

_You can't see filenames in your language correctly encoded? Please refer [`Extend Languages`](#extend-languages) section._

## Rails ActionController integration

_Rails >= 4 is supported_

Add below to Gemfile.

```ruby
gem 'ungarbled'
```

Then `bundle install`, and it's done!

Now, `send_data` (with `:filename` option) and `send_file` (with `:filename` option or without `:url_based_filename` option) will send filename encoded for specific browsers. To disable this automatic encode, try:

```ruby
# config/initializers/ungarbled.rb
Rails.configuration.ungarbled.disable_auto_encode = true
```

Even with this setting, you can still use `encode_filename` method within Controllers.

```ruby
class FilesController < ApplicationController
  def download
    send_file Rails.root.join('public', 'files', '日本語ファイル名.txt'),
              filename: encode_filename('日本語ファイル名.txt')
  end
end
```

### Optional

If you still can't see correct result, you may need encoding for specific language to be applied to filename, below configuration is required:

```ruby
# config/initializers/ungarbled.rb
Rails.configuration.ungarbled.default_lang = :ja
```

or, pass `lang` option to `encode_filename`.

```ruby
class FilesController < ApplicationController
  def download
    send_file Rails.root.join('public', 'files', '日本語ファイル名.txt'),
                        # this overrides `defalunt_lang` config
              filename: encode_filename('日本語ファイル名.txt', lang: :ja)
  end
end
```

#### Zip Support

To encode Zip item filename, use `encode_filename_for_zip_item` with setting above config.

```ruby
# Example with rubyzip

directory_to_zip = Rails.root.join('public', 'multibyte_name_files')
zipfile_name = Rails.root.join('tmp', 'multibyte_name_files.zip')

Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
  Dir[File.join(directory_to_zip, '**', '**')].each do |file|
                # ungarble!!
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

use Ungarbled::Middleware

# for specific language:
use Ungarbled::Middleware, lang: :ja
```

### Rails

_[Rails ActionController integration](#rails-ActionController-integration) is recommended._

```ruby
# config/initializers/ungarbled.rb

Rails.configuration.middleware.use Ungarbled::Middleware

# for specific language:
Rails.configuration.middleware.use Ungarbled::Middleware, lang: :ja
```

## Extend Languages

`ungarbled` authors are Japanese native, so not sure about other languages. But if you want to fix garbled download filenames in your language, please help us extending supporting language. Pull Requests are welcome!

Please see `lib/ungarbled/encoder/ja.rb` for reference, and just add your encoder file in the same directory. You can use [Browser](https://github.com/fnando/browser) instance with `@browser` for browser/platform detection. Test is also required to be added to `test/encoder/yourlanguage_test.rb`

## Future Plan

* Middleware for Zip item
* Automatic Language Detection

## Contributing

1. Fork it
1. Create your feature branch (git checkout -b my-new-feature)
1. Commit your changes (git commit -am 'Added some feature')
1. Push to the branch (git push origin my-new-feature)
1. Create new Pull Request
