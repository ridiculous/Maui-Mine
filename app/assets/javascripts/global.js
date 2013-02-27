$(function () {
    navigator.geolocation.getCurrentPosition(function (data) {
        if(window.console) console.log(data.coords);
    });
});