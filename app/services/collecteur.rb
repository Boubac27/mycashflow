require 'open-uri'
require 'nokogiri'
require 'rest-client'
require 'json'

MHASH = { "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
          "Accept-Encoding" => "gzip, deflate, br",
          "Accept-Language" => "en-US,en;q=0.9",
          "Cache-Control" => "max-age=0",
          "Connection" => "keep-alive",
          "Cookie" => "cto_lwid=69c0ed77-d029-4a67-b736-28b2a59def68; xtvrn=$562498$; xtan562498=-undefined; xtant562498=1; _fbp=fb.1.1543231319654.1050522859; _scid=820f5e50-6544-4d21-ac23-d42d28737306; consent_geo=1; consent_comp=1; consent_cookie=1; cookieBanner=1; sq=ca=22_s; saveOnboarding=1; oas_ab=a; ayl_vfvt=ayl_vfvt; uuid=cb07e4c8-5785-40be-9282-c74d0f2abfa7; ABTastySession=referrer%3D__landingPage%3Dhttps%3A//www.leboncoin.fr/recherche/%3Fcategory%3D9%26regions%3D22%26location%3D%23%7Bcity%7D__referrerSent%3Dtrue; datadome=1H99DIFcpn5ofAg5n45mg1vxgIfeoPTa5SZOJ8xOBWg; ABTasty=uid%3D18112606215648797%26fst%3D1543231316235%26pst%3D1543236990968%26cst%3D1543241705953%26ns%3D3%26pvt%3D17%26pvis%3D4%26th%3D358062.465125.7.0.3.0.1543231886659.1543238426706.1_364986.472503.1.0.3.0.1543231325322.1543231325322.1; utag_main=v_id:01674fc126c00015dc5cf7cc57d5030690019061009dc$_sn:3$_ss:0$_st:1543245570337$_pn:4%3Bexp-session$ses_id:1543241707924%3Bexp-session; _pulse2data=32b2aa0a-c62a-4724-b951-37a6057007f7%2Cv%2C%2C1543244670811%2CeyJpc3N1ZWRBdCI6IjIwMTgtMTEtMjZUMTE6MjFaIiwiZW5jIjoiQTEyOENCQy1IUzI1NiIsImFsZyI6ImRpciIsImtpZCI6IjIifQ..9g7StN_cQ96qOG0ESPR_mA.6VLEiDVE8ZS4frQNHY9vfpd1EUpJUHLDlaOjIuhn2GSJ53iRZYBUZTcDUibhnA9iXScDa8NbnHBoIsQrxCrRFVmS41-NjQgCl4u72mr8_PjlEHuc9WvqSeT216Wlh0X0uDV6jyZtomHHQHt9Kl6rQPm58Hs714zX_pk7HYaCsmfCGo_xNDWmhm14jD38eE6nlCh7ruvH0HplLy_8xO4CLRIvIShTlA0fkmmD-vqwQJY.N-mgoRd-HZa_Vi3ftnbWtQ%2C879111636836249469%2C1543258170811%2Ctrue%2C%2CeyJraWQiOiIyIiwiYWxnIjoiSFMyNTYifQ..jbhvjPa76VNz_2LFLZ0sJx-wSadj4XquWKHphqrnxeI",
          "Host" => "www.leboncoin.fr",
          "Upgrade-Insecure-Requests" => 1,
          "User-Agent" => "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36" }
NUMBER_FLATS = 10

class Collecteur
  def initialize(params)
    @city = params[:city]
    @zipcode = params[:zipcode]
    @budget = params[:budget]
  end

  def collecter
    @prices_no_selection = search_category(9, @city, @zipcode)
    @prices_no_selection.each { |appt| ap appt[:rooms] }
    @prices = @prices_no_selection.reject { |appt| appt[:price] > @budget.to_i || appt[:rooms].nil? }
    @rents = search_category(10, @city, @zipcode)
    compute_return(@prices, @rents)
    price_n_rents = {}
    price_n_rents[:prices] = @prices
    price_n_rents[:rents] = @rents
    return price_n_rents
  end

  def compute_return(appts_sold, appts_rented)
    appts_sold.each_with_index do |appt_sold, index|
      lat = appt_sold[:lat]
      lng = appt_sold[:lng]
      a_rented_sorted = appts_rented.sort { |appt| (lat - appt[:lat]) * (lat - appt[:lat]) + (lng - appt[:lng]) * (lng - appt[:lng]) }
      a_rented_excluded = a_rented_sorted.reject { |appt| appt[:price] < 200 || appt[:surface].to_f < 10 }
      a_rented_selected = a_rented_excluded.first(NUMBER_FLATS)
      lat2 = a_rented_selected[NUMBER_FLATS - 1][:lat]
      lng2 = a_rented_selected[NUMBER_FLATS - 1][:lng]
      precision = Math.sqrt((lat - lat2) * (lat - lat2) + (lng - lng2) * (lng - lng2))
      total = 0
      a_rented_selected.each do |appt|
        total += appt[:price].to_f / appt[:surface].to_f
      end
      avg_rents = total.to_f / NUMBER_FLATS.to_f
      appt_sold[:avg_rents] = avg_rents.to_f * appt_sold[:surface].to_f
      appt_sold[:returns] = appt_sold[:avg_rents].to_f / appt_sold[:price].to_f * 1200.to_f
      appt_sold[:precision] = precision
    end
  end

  def search_category(categ_number, city, zipcode)
    url = "https://www.leboncoin.fr/recherche/?category=#{categ_number}&regions=22&location=#{city}_#{zipcode}"
    html_file = RestClient.get(url, MHASH)
    html_doc = Nokogiri::HTML(html_file)
    @search_data = []
    scripts = []
    max_length = 0
    html_doc.search("script").each do |scr|
      scripts << { content: scr.content, length: scr.content.length }
      max_length = scr.content.length if scr.content.length > max_length
    end

    script = scripts.select { |scr| scr[:length] == max_length }
    scr = script[0][:content]
    obj = scr[20..scr.length - 1]
    obj_json = JSON.parse(obj)
    obj_json["adSearch"]["data"]["ads"].each_with_index do |ad, index|
      appt = {}
      if !ad["price"].nil?
        appt[:price] = ad["price"][0].to_i
        appt[:url] = ad["url"]
        appt[:image] = ad["images"]["small_url"]
        rooms = ad["attributes"].select { |attrib| attrib["key"] == "rooms" }
        appt[:rooms] = rooms[0]["value"] if !rooms[0].nil?
        surface = ad["attributes"].select { |attrib| attrib["key"] == "square" }
        appt[:surface] = surface[0]["value"] if !surface[0].nil?
        appt[:lat] = ad["location"]["lat"]
        appt[:lng] = ad["location"]["lng"]
        @search_data << appt
      end
    end

    return @search_data
  end

end
