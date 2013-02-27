var maui = {
    coords: {}
};

// dont need the coords on list page
if (window.location.pathname === '/manage') {
    navigator.geolocation.getCurrentPosition(function (data) {
        if (window.console) console.log(data.coords);
        maui.coords = data.coords;
    });
}