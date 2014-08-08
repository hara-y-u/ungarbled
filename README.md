# Ungarbled

![ungarbled](./readme/readme.png)

`ungarbled` encodes multibyte filename correctly for certain platform. Rails integration included.

## Rails ActionController integration

Put below to Gemfile.

```ruby
gem 'ungarbled'
```

Configuration.

```ruby
# config/initializers/ungarbled.rb
Rails.configuration.ungarbled.default_lang = :japanese
```

Use `encode_filename` method within Controllers.

```ruby
class FilesController < ApplicationController
  def download
    send_file Rails.root.join('public', 'files', '日本語ファイル名.txt'),
              filename: encode_filename('日本語ファイル名.txt')
    # Use "lang" option to override default language
    # encode_filename('日本語ファイル名.txt', lang: :japanese)
  end
end
```

To encode Zip item filename, use `encode_filename_for_zip_item`.

```ruby
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

### Rails Setting

```ruby
# config/initializers/ungarbled.rb

Rails.configuration.middleware.use Ungarbled::Middleware, lang: :japanese
```

## Contributing

1. Fork it
1. Create your feature branch (git checkout -b my-new-feature)
1. Commit your changes (git commit -am 'Added some feature')
1. Push to the branch (git push origin my-new-feature)
1. Create new Pull Request
