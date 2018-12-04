class HomeController < ApplicationController
  @@shuttles = Shuttle.all
  require ('open-uri')
  @@gbis = "http://m.gbis.go.kr/search/getBusStationArrival.do"
  
  def index
  end
  
  #단국대 치과병원 정류장
  def chidae
    uri1 = open(@@gbis + "?stationId=228001737")
    str_uri1 = uri1.read
    get_info1 = JSON.parse(str_uri1)["busStationArrivalInfo"]["arrivalList"]
    d_bus24 = get_info1.find{|x| x["routeName"] == "24"}
    d_bus720_3 = get_info1.find{|x| x["routeDestName"] == "단국대차고지"}
    bus24_first_h = d_bus24["firstTime"][0..1].to_i
    bus24_first_m = d_bus24["firstTime"][3..4].to_i
    bus24_last_h = d_bus24["lastTime"][0..1].to_i
    bus24_last_m = d_bus24["lastTime"][3..4].to_i
    bus720_3_first_h = d_bus720_3["firstTime"][0..1].to_i
    bus720_3_first_m = d_bus720_3["firstTime"][3..4].to_i
    bus720_3_last_h = d_bus720_3["lastTime"][0..1].to_i
    bus720_3_last_m = d_bus720_3["lastTime"][3..4].to_i
    @dental_24_1 = d_bus24["predictTime1"].to_s+"분"
    @dental_24_2 = d_bus24["predictTime2"].to_s+"분"
    @dental_720_3_1 = d_bus720_3["predictTime1"].to_s+"분"
    @dental_720_3_2 = d_bus720_3["predictTime2"].to_s+"분"
    
    now=Time.now+32400
    
    #24번 첫차,막차(평일)
    if(now.hour<bus24_first_h || (now.hour==bus24_first_h && now.min<bus24_first_m) || (now.hour==bus24_last_h && now.min>bus24_last_m))
      @dental_24_1 = "운행종료"
      @dental_24_2 = "운행종료"
    elsif(now.hour==bus24_last_h && now.min+d_bus24["predictTime1"]==bus24_last_m)
      @dental_24_2 = "운행종료"
    elsif(@dental_24_1 == "분")
      @dental_24_1 = "대기중"
      @dental_24_2 = "대기중"
    elsif(@dental_24_2 == "분")
      @dental_24_2 = "대기중"
    end
    
    #720-3번 첫차,막차(평일)
    if(now.hour<bus720_3_first_h || (now.hour==bus720_3_first_h && now.min<bus720_3_first_m) || now.hour>bus720_3_last_h || (now.hour==bus720_3_last_h && now.min>bus720_3_last_m))
      @dental_720_3_1 = "운행종료"
      @dental_720_3_2 = "운행종료"
    elsif(now.hour==bus720_3_last_h && now.min+d_bus720_3["predictTime1"]==bus720_3_last_m)
      @dental_720_3_2 = "운행종료"
    elsif(@dental_24_1 == "분")
      @dental_720_3_1 = "대기중"
      @dental_720_3_2 = "대기중"
    elsif(@dental_24_2 == "분")
      @dental_720_3_2 = "대기중"
    end
    
    #셔틀버스
    if(now.saturday? || now.sunday? || now.hour<8 ||now.hour>22 || (now.hour==22 && now.min>38))
      @dental_shuttle = "운행종료"
    end
    ifend1 = true
    @@shuttles.each do |s|
      if(now.hour >= 8 && now.hour<=10)
        @dental_shuttle = "상시운행"
      elsif(s.dental!=nil && now.hour==s.dental.hour && now.min<s.dental.min && ifend1)
        @dental_shuttle = (s.dental.min-now.min).to_s+"분"
        ifend1 = false
      elsif(s.dental!=nil && now.hour+1==s.dental.hour && ifend1)
        @dental_shuttle = (60-now.min+s.dental.min).to_s+"분"
        ifend1 = false
      end
    end
  end
  
  #단국대 곰상 정류장
  def gomsang
    uri2 = open(@@gbis + "?stationId=228001980")
    str_uri2 = uri2.read
    get_info2 = JSON.parse(str_uri2)["busStationArrivalInfo"]["arrivalList"]
    g_bus24 = get_info2.find{|x| x["routeName"] == "24"}
    g_bus720_3 = get_info2.find{|x| x["routeDestName"] == "서동탄역파크자이2차"}
    bus24_first_h = g_bus24["firstTime"][0..1].to_i
    bus24_first_m = g_bus24["firstTime"][3..4].to_i
    bus24_last_h = g_bus24["lastTime"][0..1].to_i
    bus24_last_m = g_bus24["lastTime"][3..4].to_i
    bus720_3_first_h = g_bus720_3["firstTime"][0..1].to_i
    bus720_3_first_m = g_bus720_3["firstTime"][3..4].to_i
    bus720_3_last_h = g_bus720_3["lastTime"][0..1].to_i
    bus720_3_last_m = g_bus720_3["lastTime"][3..4].to_i
    @gomsang_24_1 = g_bus24["predictTime1"].to_s+"분"
    @gomsang_24_2 = g_bus24["predictTime2"].to_s+"분"
    @gomsang_720_3_1 = g_bus720_3["predictTime1"].to_s+"분"
    @gomsang_720_3_2 = g_bus720_3["predictTime2"].to_s+"분"
    
    now=Time.now+32400
    
    #24번 첫차,막차(평일)
    if(now.hour<bus24_first_h || (now.hour==bus24_first_h && now.min<bus24_first_m) || (now.hour==bus24_last_h && now.min>bus24_last_m))
      @gomsang_24_1 = "운행종료"
      @gomsang_24_2 = "운행종료"
    elsif(now.hour==bus24_last_h && now.min+g_bus24["predictTime1"]==bus24_last_m)
      @gomsang_24_2 = "운행종료"
    elsif(@gomsang_24_1 == "분")
      @gomsang_24_1 = "대기중"
      @gomsang_24_2 = "대기중"
    elsif(@gomsang_24_2 == "분")
      @gomsang_24_2 = "대기중"
    end
    
    #720-3번 첫차,막차(평일)
    if(now.hour<bus720_3_first_h || (now.hour==bus720_3_first_h && now.min<bus720_3_first_m) || now.hour>bus720_3_last_h || (now.hour==bus720_3_last_h && now.min>bus720_3_last_m))
      @gomsang_720_3_1 = "운행종료"
      @gomsang_720_3_2 = "운행종료"
    elsif(now.hour==bus720_3_last_h && now.min+g_bus720_3["predictTime1"]==bus720_3_last_m)
      @gomsang_720_3_2 = "운행종료"
    elsif(@gomsang_720_3_1 == "분")
      @gomsang_720_3_1 = "대기중"
      @gomsang_720_3_2 = "대기중"
    elsif(@gomsang_720_3_2 == "분")
      @gomsang_720_3_2 = "대기중"
    end
    
    #셔틀버스
    if(now.saturday? || now.sunday? || now.hour<8 ||now.hour>22 || (now.hour==22 && now.min>38))
      @gomsang_shuttle = "운행종료"
    end
    ifend2 = true
    @@shuttles.each do |s|
      if(now.hour >= 8 && now.hour<=10)
        @gomsang_shuttle = "상시운행"
      elsif(s.gomsang!=nil && now.hour==s.gomsang.hour && now.min<s.gomsang.min && ifend2)
        @gomsang_shuttle = (s.gomsang.min-now.min).to_s+"분"
        ifend2 = false
      elsif(s.gomsang!=nil && now.hour+1==s.gomsang.hour && ifend2)
        @gomsang_shuttle = (60-now.min+s.gomsang.min).to_s+"분"
        ifend2 = false
      end
    end
  end
  
  #단국대 인문관 정류장
  def inmun
    uri3 = open(@@gbis + "?stationId=228001981")
    str_uri3 = uri3.read
    get_info3 = JSON.parse(str_uri3)["busStationArrivalInfo"]["arrivalList"]
    i_bus24 = get_info3.find{|x| x["routeName"] == "24"}
    i_bus720_3 = get_info3.find{|x| x["routeDestName"] == "서동탄역파크자이2차"}
    bus24_first_h = i_bus24["firstTime"][0..1].to_i
    bus24_first_m = i_bus24["firstTime"][3..4].to_i
    bus24_last_h = i_bus24["lastTime"][0..1].to_i
    bus24_last_m = i_bus24["lastTime"][3..4].to_i
    bus720_3_first_h = i_bus720_3["firstTime"][0..1].to_i
    bus720_3_first_m = i_bus720_3["firstTime"][3..4].to_i
    bus720_3_last_h = i_bus720_3["lastTime"][0..1].to_i
    bus720_3_last_m = i_bus720_3["lastTime"][3..4].to_i
    @inmun_24_1 = i_bus24["predictTime1"].to_s+"분"
    @inmun_24_2 = i_bus24["predictTime2"].to_s+"분"
    @inmun_720_3_1 = i_bus720_3["predictTime1"].to_s+"분"
    @inmun_720_3_2 = i_bus720_3["predictTime2"].to_s+"분"
    
    now=Time.now+32400
    
    #24번 첫차,막차(평일)
    if(now.hour<bus24_first_h || (now.hour==bus24_first_h && now.min<bus24_first_m) || (now.hour==bus24_last_h && now.min>bus24_last_m))
      @inmun_24_1 = "운행종료"
      @inmun_24_2 = "운행종료"
    elsif(now.hour==bus24_last_h && now.min+i_bus24["predictTime1"]==bus24_last_m)
      @inmun_24_2 = "운행종료"
    elsif(@inmun_24_1 == "분")
      @inmun_24_1 = "대기중"
      @inmun_24_2 = "대기중"
    elsif(@inmun_24_2 == "분")
      @inmun_24_2 = "대기중"
    end
    
    #720-3번 첫차,막차(평일)
    if(now.hour<bus720_3_first_h || (now.hour==bus720_3_first_h && now.min<bus720_3_first_m) || now.hour>bus720_3_last_h || (now.hour==bus720_3_last_h && now.min>bus720_3_last_m))
      @inmun_720_3_1 = "운행종료"
      @inmun_720_3_2 = "운행종료"
    elsif(now.hour==bus720_3_last_h && now.min+i_bus720_3["predictTime1"]==bus720_3_last_m)
      @inmun_720_3_2 = "운행종료"
    elsif(@inmun_720_3_1 == "분")
      @inmun_720_3_1 = "대기중"
      @inmun_720_3_2 = "대기중"
    elsif(@inmun_720_3_2 == "분")
      @inmun_720_3_2 = "대기중"
    end
    
    #셔틀버스
    if(now.saturday? || now.sunday? || now.hour<8 ||now.hour>22 || (now.hour==22 && now.min>38))
      @inmun_shuttle = "운행종료"
    end
    ifend3 = true
    @@shuttles.each do |s|
      if(now.hour >= 8 && now.hour<=10)
        @inmun_shuttle = "상시운행"
      elsif(s.inmun!=nil && now.hour==s.inmun.hour && now.min<s.inmun.min && ifend3)
        @inmun_shuttle = (s.inmun.min-now.min).to_s+"분"
        ifend3 = false
      elsif(s.inmun!=nil && now.hour+1==s.inmun.hour && ifend3)
        @inmun_shuttle = (60-now.min+s.inmun.min).to_s+"분"
        ifend3 = false
      end
    end
  end
  
  #단국대 정문 정류장
  def jungmun
    uri3 = open(@@gbis + "?stationId=228001981")
    str_uri3 = uri3.read
    get_info3 = JSON.parse(str_uri3)["busStationArrivalInfo"]["arrivalList"]
    uri4 = open(@@gbis + "?stationId=228001978")
    str_uri4 = uri4.read
    get_info4 = JSON.parse(str_uri4)["busStationArrivalInfo"]["arrivalList"]
    j_bus24 = get_info3.find{|x| x["routeName"] == "24"} #정문은 인문24 받아옴
    j_bus720_3 = get_info4.find{|x| x["routeDestName"] == "서동탄역파크자이2차"}
    bus24_first_h = j_bus24["firstTime"][0..1].to_i
    bus24_first_m = j_bus24["firstTime"][3..4].to_i
    bus24_last_h = j_bus24["lastTime"][0..1].to_i
    bus24_last_m = j_bus24["lastTime"][3..4].to_i
    bus720_3_first_h = j_bus720_3["firstTime"][0..1].to_i
    bus720_3_first_m = j_bus720_3["firstTime"][3..4].to_i
    bus720_3_last_h = j_bus720_3["lastTime"][0..1].to_i
    bus720_3_last_m = j_bus720_3["lastTime"][3..4].to_i
    @jungmun_24_1 = j_bus24["predictTime1"].to_s+"분"
    @jungmun_24_2 = j_bus24["predictTime2"].to_s+"분"
    @jungmun_720_3_1 = j_bus720_3["predictTime1"].to_s+"분"
    @jungmun_720_3_2 = j_bus720_3["predictTime2"].to_s+"분"
    
    now=Time.now+32400
    
    #24번 첫차,막차(평일)
    if(now.hour<bus24_first_h || (now.hour==bus24_first_h && now.min<bus24_first_m) || (now.hour==bus24_last_h && now.min>bus24_last_m))
      @jungmun_24_1 = "운행종료"
      @jungmun_24_2 = "운행종료"
    elsif(now.hour==bus24_last_h && now.min+j_bus24["predictTime1"]==bus24_last_m)
      @jungmun_24_2 = "운행종료"
    elsif(@jungmun_24_1 == "분")
      @jungmun_24_1 = "대기중"
      @jungmun_24_2 = "대기중"
    elsif(@jungmun_24_2 == "분")
      @jungmun_24_2 = "대기중"
    end
    
    #720-3번 첫차,막차(평일)
    if(now.hour<bus720_3_first_h || (now.hour==bus720_3_first_h && now.min<bus720_3_first_m) || now.hour>bus720_3_last_h || (now.hour==bus720_3_last_h && now.min>bus720_3_last_m))
      @jungmun_720_3_1 = "운행종료"
      @jungmun_720_3_2 = "운행종료"
    elsif(now.hour==bus720_3_last_h && now.min+j_bus720_3["predictTime1"]==bus720_3_last_m)
      @jungmun_720_3_2 = "운행종료"
    elsif(@jungmun_720_3_1 == "분")
      @jungmun_720_3_1 = "대기중"
      @jungmun_720_3_2 = "대기중"
    elsif(@jungmun_720_3_2 == "분")
      @jungmun_720_3_2 = "대기중"
    end
    
    #셔틀버스
    if(now.saturday? || now.sunday? || now.hour<8 ||now.hour>22 || (now.hour==22 && now.min>38))
      @jungmun_shuttle = "운행종료"
    end
    ifend4 = true
    @@shuttles.each do |s|
      if(now.hour >= 8 && now.hour<=10)
        @jungmun_shuttle = "상시운행"
      elsif(s.jungmun!=nil && now.hour==s.jungmun.hour && now.min<s.jungmun.min && ifend4)
        @jungmun_shuttle = (s.jungmun.min-now.min).to_s+"분"
        ifend3 = false
      elsif(s.jungmun!=nil && now.hour+1==s.jungmun.hour && ifend3)
        @jungmun_shuttle = (60-now.min+s.jungmun.min).to_s+"분"
        ifend3 = false
      end
    end
  end
  
  def shuttle
    @shuttle = @@shuttles
  end

end
