# 参考URL:https://qiita.com/hikao/items/a9864845922a24036660

require 'open-uri'
require 'nokogiri'
require 'csv'

base_url = "https://www.rakuten.co.jp/shop/"
search_word = "http://directory.rakuten.co.jp/rms/sd/directory/vc/s19tz"


private def makeShopGenreUrlAll( read_url, read_word )
  shop_genre_url_arr = Array.new
  shop_genre_html_all = Nokogiri.HTML(open(read_url))
  shop_genre_html_all.css('a').each do |element|
    url =  element[:href]
    if url.include?(read_word) then
      shop_genre_url_arr.push(element[:href])
    end
  end

  return shop_genre_url_arr

end

private def readParseURL( url )
  charset = nil
  html = open(url, "r:euc-jp").read.encode("utf-8") do |f|
    charset = f.charset
    f.read
  end
  html = Nokogiri::HTML.parse(html, nil, charset)

  return html

end

private def makeInfoArr( url )
  page_html = readParseURL(url)

  # ここの処理考えてなかった。
  # 1ページに複数のショップ情報あるんだった。
  # 多分構造が一緒で、ループで取る感じになるんじゃないかな。
  #

  for num in 0..30 do
    shop_info_arr = Array.new(size = 7, obj = "")

    # ショップ名
    puts name                        = page_html.xpath('//tbody/tr/td/font[@size="-1"]/a[@href]/b')[num]
    # 楽天ショップURL
    url                         = page_html.xpath('//tbody/tr/td/font[@size="-1"]/a[@target="_top"]')[num]
    # 感想数
    number_of_impressions       = page_html.xpath('//tbody/tr/td/a[@target="_top"]/font[@size="-1"]')[num]
    # ジャンル
    genre                       = page_html.xpath('//tbody/tr/td[@width="50%"]/font[@size="-1" and not(*)]')[num]
    # 開店日
    opening_date                = page_html.xpath('//tbody/tr[@bgcolor="#feefd5"]/td[@bgcolor="#f6f6dc"]/font[@size="-1"]')[num]
    # クレジット決済可否
    credit_propriety            = page_html.xpath('//tbody/tr[@bgcolor="#feefd5"]/td[@nowrap]/img[@src="https://r.r10s.jp/com/img/icon/cir_credit.gif" or @src="https://r.r10s.jp/com/img/icon/cir_credit_off.gif"]')[num]
    # コンビニ決済可否
    convenience_store_propriety = page_html.xpath('//tbody/tr[@bgcolor="#feefd5"]/td[@nowrap]/img[@src="https://r.r10s.jp/com/img/icon/cir_cs.gif" or @src="https://r.r10s.jp/com/img/icon/cir_cs_off.gif"]')[num]

    shop_info_arr = [name,url,number_of_impressions,genre,opening_date,credit_propriety,convenience_store_propriety]

    # shop_genre_info_all_arr.push(shop_info_arr)
  end

end


# 全てのジャンルのURLを取得する
make_shop_genre_url_all = makeShopGenreUrlAll(base_url, search_word)

# max_num = make_shop_genre_url_all.count
for shop_genre_num in 0..0

  # shop_genre_info_all_arr = Array.new # ショップジャンルURLから得られたショップ情報を貯める

  begin

    # ジャンルのURLにアクセスしてhtml情報を取得
    shop_genre_html = readParseURL(make_shop_genre_url_all[0])

    # ページ数を取得する
    all_shop_count = shop_genre_html.xpath('//tr[@valign="top"]/td[@nowrap]/font[@size="-1"]').first.to_s
    all_shop_count = all_shop_count[ all_shop_count.index("全")+2..all_shop_count.index("店")-1 ].delete!(',')
    shop_count = all_shop_count.to_i  # 全店舗数
    page_count = shop_count/30        # ページ数
    if shop_count%30 != 0 then
      page_count = page_count + 1
    end

    # 各ページの元になるURLを作成する
    onward_second_page_url = shop_genre_html.xpath('//tr[@valign="top"]/td/font[@size="-1"]/a/@href').first.to_s
    length_num = onward_second_page_url.length
    slice_num = onward_second_page_url.index("&p=")+3
    url_head = onward_second_page_url[0, slice_num]
    url_tail = onward_second_page_url[slice_num+1, length_num]

    # 各ページのURLを開く
    page_count = 1
    for page in 1..page_count
      # ページごとのURLを生成する
      onward_second_page_url = url_head + page.to_s + url_tail
      # 情報を取得して集める
      makeInfoArr(onward_second_page_url)
    end

  rescue => e
    print("Error:")
    puts e
  end

  # # ジャンル終わったらCSVで書き出す
  # # shop_genre_info_arr to CSV
  # # ファイルへ書き込み
  # CSV.open("path/to/file.csv", "wb") do |csv|
  #   csv << ["row", "of", "CSV", "data"]
  #   csv << ["another", "row"]
  #   # ...
  # end

  # 頭に戻って、次のshop_genre_url_arrを読み込む
  # puts shop_genre_info_all_arr
end


