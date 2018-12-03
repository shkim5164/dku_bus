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
    @dental_24_1 = d_bus24["predictTime1"]+"분"
    @dental_24_2 = d_bus24["predictTime2"]+"분"
    @dental_720_3_1 = d_bus720_3["predictTime1"]+"분"
    @dental_720_3_2 = d_bus720_3["predictTime2"]+"분"
    
    #셔틀버스
    now=Time.now
    if(now+32400.saturday? || now+32400.sunday?)
      @dental_shuttle = "운행종료"
    elsif(now.hour+9 >= 8 && now.hour+9<=10)
      @dental_shuttle = "상시운행"
    else
      @dental_shuttle = "운행종료"
    end
    ifend1 = true
    @@shuttles.each do |s|
      if(s.dental!=nil && now.hour+9==s.dental.hour && now.min<s.dental.min && ifend1)
        @dental_shuttle = s.dental.min-now.min+"분"
        ifend1 = false
      elsif(s.dental!=nil && now.hour+10==s.dental.hour && ifend1)
        @dental_shuttle = 60-now.min+s.dental.min+"분"
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
    @gomsang_24_1 = g_bus24["predictTime1"]
    @gomsang_24_2 = g_bus24["predictTime2"]
    @gomsang_720_3_1 = g_bus720_3["predictTime1"]
    @gomsang_720_3_2 = g_bus720_3["predictTime2"]
    
    #셔틀버스
    now=Time.now
    if(now.hour+9 >= 8 && now.hour+9<=10)
      @gomsang_shuttle = "상시운행"
    end
    ifend2 = true
    @@shuttles.each do |s|
      if(s.gomsang!=nil && now.hour+9==s.gomsang.hour && now.min<s.gomsang.min && ifend2)
        @gomsang_shuttle = s.gomsang.min-now.min
        ifend2 = false
      elsif(s.gomsang!=nil && now.hour+10==s.gomsang.hour && ifend2)
        @gomsang_shuttle = 60-now.min+s.gomsang.min
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
    @inmun_24_1 = i_bus24["predictTime1"]
    @inmun_24_2 = i_bus24["predictTime2"]
    @inmun_720_3_1 = i_bus720_3["predictTime1"]
    @inmun_720_3_2 = i_bus720_3["predictTime2"]
    
    #셔틀버스
    now=Time.now
    if(now.hour+9 >= 8 && now.hour+9<=10)
      @inmun_shuttle = "상시운행"
    end
    ifend3 = true
    @@shuttles.each do |s|
      if(s.inmun!=nil && now.hour+9==s.inmun.hour && now.min<s.inmun.min && ifend3)
        @inmun_shuttle = s.inmun.min-now.min
        ifend3 = false
      elsif(s.inmun!=nil && now.hour+10==s.inmun.hour && ifend3)
        @inmun_shuttle = 60-now.min+s.inmun.min
        ifend3 = false
      end
    end
  end
  
  #단국대 정문 정류장
  def jungmun
    uri4 = open(@@gbis + "?stationId=228001978")
    str_uri4 = uri4.read
    get_info4 = JSON.parse(str_uri4)["busStationArrivalInfo"]["arrivalList"]
    j_bus720_3 = get_info4.find{|x| x["routeDestName"] == "서동탄역파크자이2차"}
    @jungmun_24_1 = @inmun_24_1
    @jungmun_24_2 = @inmun_24_2
    @jungmun_720_3_1 = j_bus720_3["predictTime1"]
    @jungmun_720_3_2 = j_bus720_3["predictTime2"]
    
    #셔틀버스
    now=Time.now
    if(now.hour+9 >= 8 && now.hour+9<=10)
      @jungmun_shuttle = "상시운행"
    end
    ifend4 = true
    @@shuttles.each do |s|
      if(s.jungmun!=nil && now.hour+9==s.jungmun.hour && now.min<s.jungmun.min && ifend4)
        @jungmun_shuttle = s.jungmun.min-now.min
        ifend3 = false
      elsif(s.jungmun!=nil && now.hour+10==s.jungmun.hour && ifend3)
        @jungmun_shuttle = 60-now.min+s.jungmun.min
        ifend3 = false
      end
    end
  end
  
  def shuttle
    @shuttle = @@shuttles
  end
  
end
