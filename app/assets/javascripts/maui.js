var maui = {
    coords: {}
};

// get the coords if we are on the new/edit page ... root is also the new page
if (window.location.pathname === '/manage' || window.location.pathname == '/') {
    navigator.geolocation.getCurrentPosition(function (data) {
        if (window.console) console.log(data.coords);
        maui.coords = data.coords;
    });
}

function doToggleButtons(options, klass) {
    $(klass || '.toggle-button').toggleButtons($.extend({
        width: 175,
        height: 28,
        font: {},
        animated: true,
        style: {
            // Accepted values ["primary", "danger", "info", "success", "warning"] or nothing
            enabled: "success",
            disabled: "danger"
        },
        onChange: function () {
        }
    }, options || {}));
}