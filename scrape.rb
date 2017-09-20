require 'open-uri'
require 'nokogiri'
require 'csv'

# ページに含まれるショップジャンルURLを配列に格納する
url = Nokogiri.HTML(open("https://www.rakuten.co.jp/shop/"))
shop_genre_url_arr = Array.new
url.css('a').each do |element|
  url =  element[:href]
  if url.include?("http://directory.rakuten.co.jp/rms/sd/directory/vc/s19tz") then
    shop_genre_url_arr.push(element[:href])
  end
end

# ショップジャンルURLを開く
for shop_genre_num in 0..shop_genre_url_arr.count in

  shop_url = Nokogiri.HTML(open(shop_genre_url_arr[shop_genre_num]))

  # ショップジャンルURLから得られたショップ情報を貯める
  shop_genre_info_arr = Array.new

  # 1ページ目の情報を取得する
  shop_info_arr = Array.new(size = 7, obj = "")
  name = ""
  url = ""
  number_of_impressions = ""
  genre = ""
  opening_date = ""
  credit_propriety = ""
  convenience_store_propriety = ""
  shop_info_arr = [name,url,number_of_impressions,genre,opening_date,credit_propriety,convenience_store_propriety]
  shop_genre_info_arr.push(shop_info_arr)

  # 2ページ目以降のページに移動する
  # 全店舗数を取得する
  all_shop_count
  # 全店舗数÷30件でページ数を出す
  all_page_count = all_shop_count/30
  # ページURL
  page_url = "https://directory.rakuten.co.jp/rms/sd/directory/vc?s=19&tz=100371&v=2&f=0&p=9&o=35&oid=000&k=0&a=1"

  for shop_page_num in 1..all_page_count then
    # &p= のページ部分を切り替えてページのurlを生成する
    page_url  = "https://directory.rakuten.co.jp/rms/sd/directory/vc?s=19&tz=100371&v=2&f=0&p=" + shop_page_num + "&o=35&oid=000&k=0&a=1"

    page_url = Nokogiri.HTML(open(page_url))

    name = ""
    url = ""
    number_of_impressions = ""
    genre = ""
    opening_date = ""
    credit_propriety = ""
    convenience_store_propriety = ""
    shop_info_arr = [name,url,number_of_impressions,genre,opening_date,credit_propriety,convenience_store_propriety]
    shop_genre_info_arr.push(shop_info_arr)

  end

  # ジャンル終わったらCSVで書き出す
  # shop_genre_info_arr to CSV
  # ファイルへ書き込み
  CSV.open("path/to/file.csv", "wb") do |csv|
    csv << ["row", "of", "CSV", "data"]
    csv << ["another", "row"]
    # ...
  end

  # 頭に戻って、次のshop_genre_url_arrを読み込む

end


