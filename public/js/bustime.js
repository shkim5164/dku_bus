var timer;
function printBus(place){
    $.ajax({ 
        type: 'get',
        async: false,
        url: '/home/'+place, 
        dataType : 'html',
        success: function(data){
            // all = data;
            console.log(place+'가져옴');
            var e = $(data).find('#'+place);
            $("#listDiv").html(e);
        }
    });
    timer = setTimeout("printBus('"+place+"')", 10000);
}

function choosePlace(place){
    clearTimeout(timer);
    printBus(place);
}