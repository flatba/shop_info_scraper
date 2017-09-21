# 参考URL:https://qiita.com/hikao/items/a9864845922a24036660

require 'open-uri'
require 'nokogiri'
require 'csv'


base_url = "https://www.rakuten.co.jp/shop/"
search_word = "http://directory.rakuten.co.jp/rms/sd/directory/vc/s19tz"
shop_genre_info_all_arr = Array.new # ショップジャンルURLから得られたショップ情報を貯める

# [DONE]ページに含まれるショップジャンルURLを配列に格納する
def make_shop_genre_url_arr( read_url, read_word )
  shop_genre_url_arr = Array.new
  url = Nokogiri.HTML(open(read_url))
  url.css('a').each do |element|
    url =  element[:href]
    if url.include?(read_word) then
      shop_genre_url_arr.push(element[:href])
    end
  end
  return shop_genre_url_arr
end

make_shop_genre_url_all = make_shop_genre_url_arr(base_url, search_word)
# puts make_shop_genre_url_all


# private def makeArr(url)
#   # urlを渡すと、必要情報を取り出して変数に格納して、かつそれらを配列に入れたものをreturnしてくれる関数
#   shop_info_arr = Array.new(size = 7, obj = "")
#   name                        = "ショップ名"
#   url                         = "楽天ショップURL"
#   number_of_impressions       = "感想数"
#   genre                       = "ジャンル"
#   opening_date                = "開店日"
#   credit_propriety            = "クレジット決済可否"
#   convenience_store_propriety = "コンビニ決済可否"
#   shop_info_arr = [name,url,number_of_impressions,genre,opening_date,credit_propriety,convenience_store_propriety]
#   return shop_info_arr
# end


# ショップジャンルURLを開く
# max_num = make_shop_genre_url_all.count
max_num = 1
for shop_genre_num in 0..max_num

  begin

    url = make_shop_genre_url_all[shop_genre_num]
    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end
    shop_genre_url = Nokogiri::HTML.parse(html, nil, charset)

    # 1ページ目の情報を取得する
    # shop_info_arr = makeArr(shop_url)
    shop_info_arr = Array.new(size = 7, obj = "")
    name                        = "ショップ名"
    url                         = "楽天ショップURL"
    number_of_impressions       = "感想数"
    genre                       = shop_genre_url.title # "ジャンル"
    opening_date                = "開店日"
    credit_propriety            = "クレジット決済可否"
    convenience_store_propriety = "コンビニ決済可否"
    shop_info_arr = [name,url,number_of_impressions,genre,opening_date,credit_propriety,convenience_store_propriety]
    shop_genre_info_all_arr.push(shop_info_arr)

    # puts shop_genre_info_all_arr

    # puts
    # puts shop_genre_url.at('//tbody')

  rescue => e
    print("Error:")
    puts e
  end

  # xpath地獄にハマるので、具体的な値の取得より先にロジックを組んでしまいます。

  # 2件目以降のURLを取得するためのベース
  onward_second_page_url = shop_genre_url.xpath('//tr[@valign="top"]/td/font[@size="-1"]/a/@href').first.to_s
  length_num = onward_second_page_url.length
  slice_num = onward_second_page_url.index("&p=")+3
  url_head = onward_second_page_url[0, slice_num]
  url_tail = onward_second_page_url[slice_num+1, length_num]
  onward_second_page_url = url_head + "あああ" + url_tail

  # # 2ページ目以降のページに移動する
  # # 全店舗数を取得する
  # all_shop_count　= 300
  # # 全店舗数÷30件でページ数を出す
  # all_page_count = all_shop_count/30
  # # そのジャンルの2ページ以降のページURL
  # page_url = "https://directory.rakuten.co.jp/rms/sd/directory/vc?s=19&tz=100371&v=2&f=0&p=9&o=35&oid=000&k=0&a=1"
  # puts page_url

  # for shop_page_num in 1..all_page_count then
  #   # &p= のページ部分を切り替えてページのurlを生成する
  #   page_url_str  = "https://directory.rakuten.co.jp/rms/sd/directory/vc?s=19&tz=100371&v=2&f=0&p=" + shop_page_num + "&o=35&oid=000&k=0&a=1"

  #   page_url = Nokogiri.HTML(open(page_url))

  #   # shop_info_arr = makeArr(page_url)
  #   shop_info_arr = Array.new(size = 7, obj = "")
  #   name                        = "ショップ名"
  #   url                         = "楽天ショップURL"
  #   number_of_impressions       = "感想数"
  #   genre                       = "ジャンル"
  #   opening_date                = "開店日"
  #   credit_propriety            = "クレジット決済可否"
  #   convenience_store_propriety = "コンビニ決済可否"
  #   shop_info_arr = [name,url,number_of_impressions,genre,opening_date,credit_propriety,convenience_store_propriety]
  #   shop_genre_info_all_arr.push(shop_info_arr)

  # end

  # # ジャンル終わったらCSVで書き出す
  # # shop_genre_info_arr to CSV
  # # ファイルへ書き込み
  # CSV.open("path/to/file.csv", "wb") do |csv|
  #   csv << ["row", "of", "CSV", "data"]
  #   csv << ["another", "row"]
  #   # ...
  # end

  # 頭に戻って、次のshop_genre_url_arrを読み込む

end

puts onward_second_page_url

