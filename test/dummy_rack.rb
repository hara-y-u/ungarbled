require 'rubygems'
require 'rack'
require 'rack/test'

class DummyRackApp
  BODY = 'abcde'

  def call(env)
    case env['PATH_INFO']
    when '/download'
      [200, {
        'Content-Type' => 'application/octet-stream',
        'Content-Disposition' => 'attachment; filename="filename.txt"',
        'Content-Transfer-Encoding' => 'binary'
       }, [BODY]
      ]
    when '/download_multibyte'
      [200, {
        'Content-Type' => 'application/octet-stream',
        'Content-Disposition' => 'attachment; filename="日本語ファイル名.txt"',
        'Content-Transfer-Encoding' => 'binary'
       }, [BODY]
      ]
    end
  end
end
