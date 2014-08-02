class FilesController < ApplicationController
  def download_with_encode_filename
    send_data 'abcde',
              filename: encode_filename('日本語ファイル名.txt',
                                        language: :japanese
                                       ),
              disposition: 'attachment'
  end

  def download_with_changing_language
    filename = encode_filename('日本語ファイル名.txt',
                               language: :japanese
                              )

    filename_changed = encode_filename('日本語ファイル名.txt',
                                       language: :base
                                      )

    send_data 'abcde',
              filename: filename_changed,
              disposition: 'attachment'
  end
end
