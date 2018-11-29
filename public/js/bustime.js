var all;
function printBus(){ 
    $.ajax({ 
        type: 'get',
        async: false,
        url: '/home/bus', 
        dataType : 'html',
        success: function(data){
            all = data;
            console.log('가져옴');
        }
        });
    setTimeout('printBus()', 10000);
}
function first(){
    $.ajax({ 
        type: 'get',
        async: false,
        url: '/home/bus', 
        dataType : 'html',
        success: function(data){
            all = data;
            console.log('가져옴');
            var e = $(data).find('#chidae');	
            $("#listDiv").html(e);
        }
    });
    printBus();
}
function choosePlace(place){
    var e = $(all).find(place);	
    $("#listDiv").html(e);
}