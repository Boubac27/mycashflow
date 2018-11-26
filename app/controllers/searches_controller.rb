require 'open-uri'
require 'nokogiri'
require 'rest-client'

MHASH = { "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
              "Accept-Encoding" => "gzip, deflate, br",
              "Accept-Language" => "en-US,en;q=0.9",
              "Cache-Control" => "max-age=0",
              "Connection" => "keep-alive",
              "Cookie" => "cto_lwid=69c0ed77-d029-4a67-b736-28b2a59def68; xtvrn=$562498$; xtan562498=-undefined; xtant562498=1; _fbp=fb.1.1543231319654.1050522859; _scid=820f5e50-6544-4d21-ac23-d42d28737306; consent_geo=1; consent_comp=1; consent_cookie=1; cookieBanner=1; sq=ca=22_s; saveOnboarding=1; oas_ab=a; ayl_vfvt=ayl_vfvt; uuid=cb07e4c8-5785-40be-9282-c74d0f2abfa7; ABTastySession=referrer%3D__landingPage%3Dhttps%3A//www.leboncoin.fr/recherche/%3Fcategory%3D9%26regions%3D22%26location%3D%23%7Bcity%7D__referrerSent%3Dtrue; datadome=1H99DIFcpn5ofAg5n45mg1vxgIfeoPTa5SZOJ8xOBWg; ABTasty=uid%3D18112606215648797%26fst%3D1543231316235%26pst%3D1543236990968%26cst%3D1543241705953%26ns%3D3%26pvt%3D17%26pvis%3D4%26th%3D358062.465125.7.0.3.0.1543231886659.1543238426706.1_364986.472503.1.0.3.0.1543231325322.1543231325322.1; utag_main=v_id:01674fc126c00015dc5cf7cc57d5030690019061009dc$_sn:3$_ss:0$_st:1543245570337$_pn:4%3Bexp-session$ses_id:1543241707924%3Bexp-session; _pulse2data=32b2aa0a-c62a-4724-b951-37a6057007f7%2Cv%2C%2C1543244670811%2CeyJpc3N1ZWRBdCI6IjIwMTgtMTEtMjZUMTE6MjFaIiwiZW5jIjoiQTEyOENCQy1IUzI1NiIsImFsZyI6ImRpciIsImtpZCI6IjIifQ..9g7StN_cQ96qOG0ESPR_mA.6VLEiDVE8ZS4frQNHY9vfpd1EUpJUHLDlaOjIuhn2GSJ53iRZYBUZTcDUibhnA9iXScDa8NbnHBoIsQrxCrRFVmS41-NjQgCl4u72mr8_PjlEHuc9WvqSeT216Wlh0X0uDV6jyZtomHHQHt9Kl6rQPm58Hs714zX_pk7HYaCsmfCGo_xNDWmhm14jD38eE6nlCh7ruvH0HplLy_8xO4CLRIvIShTlA0fkmmD-vqwQJY.N-mgoRd-HZa_Vi3ftnbWtQ%2C879111636836249469%2C1543258170811%2Ctrue%2C%2CeyJraWQiOiIyIiwiYWxnIjoiSFMyNTYifQ..jbhvjPa76VNz_2LFLZ0sJx-wSadj4XquWKHphqrnxeI",
              "Host" => "www.leboncoin.fr",
              "Upgrade-Insecure-Requests" => 1,
              "User-Agent" => "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36" }


class SearchesController < ApplicationController
  def create
    # category 9 : ventes immobilières
    # category 10 : locations

    @prices = search_category(9)
    @rents = search_category(10)
    search_surface(@rents)

  end

  def search_surface(rents)
    rents.each do |rent|
      url = rent[:url]
      html_file = RestClient.get(url, MHASH)
      html_doc = Nokogiri::HTML(html_file)
      @search_data = []
      # ap html_doc
      regexp = /Surface\d+/
      html_doc.search("main > div > div > div").each_with_index do |div_surf, ind|
        # puts "---------------------------------------------------------------------------------------------------------------"
        # puts "index = #{ind}"
        # ap div_surf.content if ind == 0
        surface_text = regexp.match(div_surf.content)
        surface_text = surface_text.to_s
        rent[:surface] = surface_text[7..surface_text.size - 1].to_i
        ap rent
      end
      # html_doc.search("main > div > div > div > section > section > section > div > div > div > div > div").each_with_index do |div_surf, ind|
      #   ap div_surf.content if ind == 0
      # end
    end
  end

  def search_category(categ_number)
    city = "Lyon"
    url = "https://www.leboncoin.fr/recherche/?category=#{categ_number}&regions=22&location=#{city}"
    html_file = RestClient.get(url, MHASH)
    html_doc = Nokogiri::HTML(html_file)
    counter = 0
    @search_data = []
    html_doc.search("li > a").each do |link|
      # p link
      price = 0
      link.search("span > span").each do |span_price|
        price = span_price.content
      end
      end_appt_url = link['href']
      appt_url = "https://www.leboncoin.fr#{end_appt_url}"
      html_appt = RestClient.get(appt_url, MHASH)
      data_appt = { price: price, url: appt_url }
      @search_data << data_appt
      counter += 1
      return @search_data if counter == 5

    end

  end

  # def search_rents
  #   city = "Lyon"
  #   url = "https://www.leboncoin.fr/recherche/?category=10&regions=22&location=#{city}"
  #   mhash = { "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
  #             "Accept-Encoding" => "gzip, deflate, br",
  #             "Accept-Language" => "en-US,en;q=0.9",
  #             "Cache-Control" => "max-age=0",
  #             "Connection" => "keep-alive",
  #             "Cookie" => "cto_lwid=69c0ed77-d029-4a67-b736-28b2a59def68; xtvrn=$562498$; xtan562498=-undefined; xtant562498=1; _fbp=fb.1.1543231319654.1050522859; _scid=820f5e50-6544-4d21-ac23-d42d28737306; consent_geo=1; consent_comp=1; consent_cookie=1; cookieBanner=1; sq=ca=22_s; saveOnboarding=1; oas_ab=a; ayl_vfvt=ayl_vfvt; uuid=cb07e4c8-5785-40be-9282-c74d0f2abfa7; ABTastySession=referrer%3D__landingPage%3Dhttps%3A//www.leboncoin.fr/recherche/%3Fcategory%3D9%26regions%3D22%26location%3D%23%7Bcity%7D__referrerSent%3Dtrue; datadome=1H99DIFcpn5ofAg5n45mg1vxgIfeoPTa5SZOJ8xOBWg; ABTasty=uid%3D18112606215648797%26fst%3D1543231316235%26pst%3D1543236990968%26cst%3D1543241705953%26ns%3D3%26pvt%3D17%26pvis%3D4%26th%3D358062.465125.7.0.3.0.1543231886659.1543238426706.1_364986.472503.1.0.3.0.1543231325322.1543231325322.1; utag_main=v_id:01674fc126c00015dc5cf7cc57d5030690019061009dc$_sn:3$_ss:0$_st:1543245570337$_pn:4%3Bexp-session$ses_id:1543241707924%3Bexp-session; _pulse2data=32b2aa0a-c62a-4724-b951-37a6057007f7%2Cv%2C%2C1543244670811%2CeyJpc3N1ZWRBdCI6IjIwMTgtMTEtMjZUMTE6MjFaIiwiZW5jIjoiQTEyOENCQy1IUzI1NiIsImFsZyI6ImRpciIsImtpZCI6IjIifQ..9g7StN_cQ96qOG0ESPR_mA.6VLEiDVE8ZS4frQNHY9vfpd1EUpJUHLDlaOjIuhn2GSJ53iRZYBUZTcDUibhnA9iXScDa8NbnHBoIsQrxCrRFVmS41-NjQgCl4u72mr8_PjlEHuc9WvqSeT216Wlh0X0uDV6jyZtomHHQHt9Kl6rQPm58Hs714zX_pk7HYaCsmfCGo_xNDWmhm14jD38eE6nlCh7ruvH0HplLy_8xO4CLRIvIShTlA0fkmmD-vqwQJY.N-mgoRd-HZa_Vi3ftnbWtQ%2C879111636836249469%2C1543258170811%2Ctrue%2C%2CeyJraWQiOiIyIiwiYWxnIjoiSFMyNTYifQ..jbhvjPa76VNz_2LFLZ0sJx-wSadj4XquWKHphqrnxeI",
  #             "Host" => "www.leboncoin.fr",
  #             "Upgrade-Insecure-Requests" => 1,
  #             "User-Agent" => "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36" }
  #   html_file = RestClient.get(url, mhash)
  #   html_doc = Nokogiri::HTML(html_file)
  #   html_doc.search("li > a").each do |link|
  #   price = 0
  #   link.search("span > span").each do |span_price|
  #     price = span_price.content
  #   end
  #   end_appt_url = link['href']
  #   appt_url = "https://www.leboncoin.fr#{end_appt_url}"
  #   html_appt = RestClient.get(appt_url, mhash)
  #   data_appt = { price: price, url: appt_url }
  #   @search_data << data_appt
  #   counter += 1
  #   return if counter == 10

  # end

end
