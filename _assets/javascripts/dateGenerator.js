function insertEmagramm() {
    var d = new Date();
    var year = d.getFullYear().toString();
    var month = (d.getMonth() + 1).toString();
    month = ('0' + month).slice(-2);
    var day = (d.getDate() - 1).toString();
    day = ('0' + day).slice(-2);
    var dateString = year + month + day;
    var ema1 = "<img src='/loader.gif' data-layzr='http://www.meteoswiss.admin.ch/product/input/radio-soundings/VSSG76.LSSW_";
    var ema2 = "_1200.gif'>";
    var emaURL = ema1 + dateString + ema2;
    document.getElementById("emagramm").innerHTML = emaURL;
}
insertEmagramm();
var layzr = new Layzr();
layzr.update();