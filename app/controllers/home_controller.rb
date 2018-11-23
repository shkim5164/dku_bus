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
    @dental_720_3 = get_info1[1]["predictTime1"]
    
    #단국대 곰상 정류장
    uri2 = open(gbis + "?stationId=228001980")
    str_uri2 = uri2.read
    get_info2 = JSON.parse(str_uri2)["busStationArrivalInfo"]["arrivalList"]
    @gomsang_24 = get_info2[2]["predictTime1"]
    @gomsang_720_3 = get_info2[1]["predictTime1"]
    
    #단국대 인문관 정류장
    uri3 = open(gbis + "?stationId=228001981")
    str_uri3 = uri3.read
    get_info3 = JSON.parse(str_uri3)["busStationArrivalInfo"]["arrivalList"]
    @inmun_24 = get_info3[2]["predictTime1"]
    @inmun_720_3 = get_info3[1]["predictTime1"]
    
    #셔틀버스
    now=Time.now.min
    ifend1 = true
    ifend2 = true
    ifend3 = true
    @@shuttles.each do |s|
      if(s.dental!=nil && now<s.dental.min && ifend1) #치대
        @dental_shuttle = s.dental.min-now
        ifend1 = false
      end
      if(s.gomsang!=nil && now<s.gomsang.min && ifend2) #곰상
        @gomsang_shuttle = s.gomsang.min-now
        ifend2 = false
      end
      if(s.inmun!=nil && now<s.inmun.min && ifend3) #인문
        @inmun_shuttle = s.inmun.min-now
        ifend3 = false
      end
    end
    
  end
end
