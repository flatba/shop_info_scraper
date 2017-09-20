# 参考URL:https://qiita.com/hikao/items/a9864845922a24036660

require 'open-uri'
require 'nokogiri'
require 'csv'


# [DONE]ページに含まれるショップジャンルURLを配列に格納する
def make_shop_genre_url_arr(url_base)
  shop_genre_url_arr = Array.new
  url = Nokogiri.HTML(open(url_base))
  url.css('a').each do |element|
    url =  element[:href]
    if url.include?("http://directory.rakuten.co.jp/rms/sd/directory/vc/s19tz") then
      shop_genre_url_arr.push(element[:href])
    end
  end
  return shop_genre_url_arr
end

make_shop_genre_url_all_arr = make_shop_genre_url_arr("https://www.rakuten.co.jp/shop/")
puts make_shop_genre_url_all_arr


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
# max_num = shop_genre_url_arr.count
max_num = 2
for shop_genre_num in 0..max_num

  shop_genre_url = Nokogiri.HTML(open(make_shop_genre_url_all_arr[shop_genre_num]))
  # shop_genre_url.css('a').each do |element|
  #   url =  element[:href]
  #   puts url
  # end
Nokogiriのopenは２個行けるのはわかった


  # shop_genre_url.css('a').each do |element|
  #   url =  element[:href] # URL

  # end

  # # ショップジャンルURLから得られたショップ情報を貯める
  # shop_genre_info_all_arr = Array.new

  # # 1ページ目の情報を取得する
  # # shop_info_arr = makeArr(shop_url)
  # shop_info_arr = Array.new(size = 7, obj = "")
  # name                        = "ショップ名"
  # url                         = "楽天ショップURL"
  # number_of_impressions       = "感想数"
  # genre                       = "ジャンル"
  # opening_date                = "開店日"
  # credit_propriety            = "クレジット決済可否"
  # convenience_store_propriety = "コンビニ決済可否"
  # shop_info_arr = [name,url,number_of_impressions,genre,opening_date,credit_propriety,convenience_store_propriety]
  # shop_genre_info_all_arr.push(shop_info_arr)

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


