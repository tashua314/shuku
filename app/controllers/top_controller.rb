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
    page = agent.get('http://maxdelivery.com')

    form = page.form('SearchForm')
    form.searchString = "ham"
    page = agent.submit(form)

    @items = []
    page.search("div.search-item").each_with_index do |item, i|
      @items << item.attr('data-name')
    end
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
