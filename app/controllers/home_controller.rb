class HomeController < ApplicationController
  
  def index
  end
  
  def bus
    require ('open-uri')
    gbis = "http://m.gbis.go.kr/search/getBusStationArrival.do"
    
    #단국대 치과병원 정류장
    uri1 = open(gbis + "?stationId=228001737")
    str_uri1 = uri1.read
    get_info1 = JSON.parse(str_uri1)["busStationArrivalInfo"]["arrivalList"]
    @dentist_bus24 = get_info1[5]["predictTime1"]
    @dentist_bus720_3 = get_info1[1]["predictTime1"]
    #단국대 곰상 정류장
    uri2 = open(gbis + "?stationId=228001980")
    str_uri2 = uri2.read
    get_info2 = JSON.parse(str_uri2)["busStationArrivalInfo"]["arrivalList"]
    @gomsang_bus24 = get_info2[2]["predictTime1"]
    @gomsang_bus720_3 = get_info2[1]["predictTime1"]
  end
end
