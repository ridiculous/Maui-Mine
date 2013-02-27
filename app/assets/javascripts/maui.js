var maui = {
    coords: {}
};

// dont need the coords on list page
if (window.location.pathname === '!/manage') {
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