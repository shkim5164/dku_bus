class HomeController < ApplicationController
  @@shuttles = Shuttle.all
  
  def index
  end
  
  def bus
    require ('open-uri')
    gbis = "http://m.gbis.go.kr/search/getBusStationArrival.do"
    
    #단국대 치과병원 정류장
    uri1 = open(gbis + "?stationId=228001737")
    str_uri1 = uri1.read
    get_info1 = JSON.parse(str_uri1)["busStationArrivalInfo"]["arrivalList"]
    @dental_24 = get_info1[5]["predictTime1"]
    @dental_720_3 = get_info1[0]["predictTime1"]
    
    #단국대 곰상 정류장
    uri2 = open(gbis + "?stationId=228001980")
    str_uri2 = uri2.read
    get_info2 = JSON.parse(str_uri2)["busStationArrivalInfo"]["arrivalList"]
    @gomsang_24 = get_info2[2]["predictTime1"]
    @gomsang_720_3 = get_info2[0]["predictTime1"]
    
    #단국대 인문관 정류장
    uri3 = open(gbis + "?stationId=228001981")
    str_uri3 = uri3.read
    get_info3 = JSON.parse(str_uri3)["busStationArrivalInfo"]["arrivalList"]
    @inmun_24 = get_info3[2]["predictTime1"]
    @inmun_720_3 = get_info3[0]["predictTime1"]
    
    #단국대 정문 정류장
    uri4 = open(gbis + "?stationId=228001978")
    str_uri4 = uri4.read
    get_info4 = JSON.parse(str_uri4)["busStationArrivalInfo"]["arrivalList"]
    @jungmun_24 = @inmun_24
    @jungmun_720_3 = get_info3[0]["predictTime1"]
    
    #셔틀버스
    now=Time.now
    if(now.hour+9 >= 8 && now.hour+9<=10)
      @dental_shuttle = "상시운행"
      @gomsang_shuttle = "상시운행"
      @inmun_shuttle = "상시운행"
      @jungmun_shuttle = "상시운행"
    end
    
    ifend1 = true
    ifend2 = true
    ifend3 = true
    ifend4 = true
    @@shuttles.each do |s|
      #치대
      if(s.dental!=nil && now.hour+9==s.dental.hour && now.min<s.dental.min && ifend1)
        @dental_shuttle = s.dental.min-now.min
        ifend1 = false
      elsif(s.dental!=nil && now.hour+10==s.dental.hour && ifend1)
        @dental_shuttle = 60-now.min+s.dental.min
        ifend1 = false
      end
      
      #곰상
      if(s.gomsang!=nil && now.hour+9==s.gomsang.hour && now.min<s.gomsang.min && ifend2)
        @gomsang_shuttle = s.gomsang.min-now.min
        ifend2 = false
      elsif(s.gomsang!=nil && now.hour+10==s.gomsang.hour && ifend2)
        @gomsang_shuttle = 60-now.min+s.gomsang.min
        ifend2 = false
      end
      
      #인문
      if(s.inmun!=nil && now.hour+9==s.inmun.hour && now.min<s.inmun.min && ifend3)
        @inmun_shuttle = s.inmun.min-now.min
        ifend3 = false
      elsif(s.inmun!=nil && now.hour+10==s.inmun.hour && ifend3)
        @inmun_shuttle = 60-now.min+s.inmun.min
        ifend3 = false
      end
      
      #정문
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
