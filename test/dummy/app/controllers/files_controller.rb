class FilesController < ApplicationController
  def download
    send_data 'abcde',
              filename: encode_filename('日本語ファイル名.txt',
                                        language: :base
                                       ),
              disposition: 'attachment'
  end

  def download_with_encode_filename
    send_data 'abcde',
              filename: encode_filename('日本語ファイル名.txt',
                                        language: :japanese
                                       ),
              disposition: 'attachment'
  end
end
