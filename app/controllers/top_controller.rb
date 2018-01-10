class TopController < ApplicationController
  require 'open-uri'
  require 'nokogiri'
  require 'mechanize'

  def index
    # スクレイピング先のURL
    url = 'http://www.yahoo.co.jp/'
    html, charset = open_html(url)
    # htmlをパース(解析)してオブジェクトを生成
    doc = Nokogiri::HTML.parse(html, nil, charset)
    # タイトルを表示
    @title = doc.title
  end

  def show
    agent = Mechanize.new
    page = agent.get('http://kosei-do.com/free_fortune_telling/select_uranai_type.php')

    form = page.form('fm_basic')
    # form = page.form('fm_relation')
    form.year_basic = "1986"
    form.month_basic = "4"
    form.day_basic = "3"
    form.action = "/free_fortune_telling/basic_uranai.php"
    page = agent.submit(form)

    @item = page.search(".bu-yado-name").text
    binding.pry
    @items = []
    # page.search("div.search-item").each_with_index do |item, i|
    #   @items << item.attr('data-name')
    # end
  end

  private

  def open_html(url)
    charset = nil
    html = open(url) do |file|
      charset = file.charset # 文字種別を取得
      file.read # htmlを読み込んで変数htmlに渡す
    end
    return html, charset
  end
end
