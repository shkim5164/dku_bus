class HomeController < ApplicationController
  require ('open-uri')
  @@gbis = "http://m.gbis.go.kr/search/getBusStationArrival.do"
  
  def index
     #uri를 열기 위한 루비에 자동으로 설치된 잼 같은것. 
     uri = open(@@gbis + "?stationId=228001737")
     #uri라는 변수에 버스정보가 담긴 url을 열어서 저장함. 
     str_uri = uri.read
     #str_uri라는 변수에 uri변수에 저장한 것을 읽어오도록 저장. 
     get_info = JSON.parse(str_uri)["busStationArrivalInfo"]["arrivalList"]
     #get_info라는 변수에 JSON 형식으로 str_uri에 저장된 것을 담아둠. => 해쉬형식으로 담겨짐
     @bus24 = get_info[5]["predictTime1"]
     @bus720_3 = get_info[1]["predictTime1"]
  end
  
  def gomsang
      uri = open(@@gbis + "?stationId=228001980")
      str_uri = uri.read
      get_info = JSON.parse(str_uri)["busStationArrivalInfo"]["arrivalList"]
      @bus24 = get_info[2]["predictTime1"]
      @bus720_3 = get_info[1]["predictTime1"]
  end
end
