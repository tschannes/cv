window.addEventListener("keyup", checkKeyPressed, false);
window.addEventListener("touchstart", doubletap, false);

function checkKeyPressed(e) {
    e.preventDefault();
    if (e.keyCode == "17") {
        doubletap();
    }
}

var mylatesttap;

function doubletap() {

    var now = new Date().getTime();
    var timesince = now - mylatesttap;
    if ((timesince < 600) && (timesince > 0)) {
        var el = document.getElementById('searchContainer');
        if (el.style.display == "none" | el.style.display === "") {
            el.style.display = "block";
        } else {
            el.style.display = "none";
        }
    } else {
        // too much time to be a doubletap
    }
    mylatesttap = new Date().getTime();
}