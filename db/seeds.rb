# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
for h in (8..22)
    t = Time.new(1,1,1,h,0,0)
    
    if(h<=10)
        Shuttle.create(gomsang: t) #8시~10시: 상시출발
    else
        Shuttle.create(gomsang: t, inmun: t+60, jungmun: t+120, jukjeon: t+600, dental: t+1080) # 정각 출발
        
        if(h==16)
            t4 = t+300 # 5분 춟발
            Shuttle.create(gomsang: t4, inmun: t4+60, jungmun: t4+120, jukjeon: t4+600, dental: t4+1080)
            t5 = t+600 # 10분 출발
            Shuttle.create(gomsang: t5, inmun: t5+60, jungmun: t5+120, jukjeon: t5+600, dental: t5+1080)
        end
        
        t1 = t+1200 # 20분 출발
        if(h==15)
            t1=t1+300 # 25분 출발
        elsif(h==17 || h==18)
            t1=t1-300 # 15분 출발
        end
        Shuttle.create(gomsang: t1, inmun: t1+60, jungmun: t1+120, jukjeon: t1+600, dental: t1+1080)
        
        t2 = t+2400 # 40분 출발
        if(h>=16 && h<=18)
            t2 = t2-600 # 30분 출발
        end
        if(h==22) # 막차
            Shuttle.create(gomsang: t2, inmun: t2+60, jungmun: t2+120, jukjeon: t2+600 )
        elsif
            Shuttle.create(gomsang: t2, inmun: t2+60, jungmun: t2+120, jukjeon: t2+600, dental: t2+1080)
        end
        
        if(h<=12 || h>=15 && h<=18)
            t3 = t+3000 # 50분 출발
            if(h>=16 && h<=18)
                t3 = t3-300 # 45분 출발
            end
            Shuttle.create(gomsang: t3, inmun: t3+60, jungmun: t3+120, jukjeon: t3+600, dental: t3+1080)
        end
        
    end
end