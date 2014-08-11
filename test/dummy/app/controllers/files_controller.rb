# -*- encoding: utf-8 -*-

class FilesController < ApplicationController
  def download_with_encode_filename
    send_data 'abcde',
              filename: encode_filename('日本語ファイル名.txt',
                                        lang: :ja
                                       ),
              disposition: 'inline'
  end

  def download_without_encode_filename
    send_data 'abcde',
              filename: '日本語ファイル名.txt',
              disposition: 'attachment'
  end

  def download_without_lang_specified
    send_data 'abcde',
              filename: encode_filename('日本語ファイル名.txt'),
              disposition: 'attachment'
  end

  def download_with_changing_lang
    filename = encode_filename('日本語ファイル名.txt',
                               lang: :ja
                              )

    filename_changed = encode_filename('日本語ファイル名.txt',
                                       lang: :base
                                      )

    send_data 'abcde',
              filename: filename_changed,
              disposition: 'attachment'
  end
end
