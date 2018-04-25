window.addEventListener('DOMContentLoaded', init, false);

window.onload = init;


function init() {
var buttons = document.getElementsByTagName("button")
buttons[0].addEventListener('click', changeColor,false)
    }


function changeColor2() {
var pars = document.getElementsByTagName('spGrp')
    for (var i = 0, length = pars.length; i < length; i++) {
        pars[i].style.backgroundColor = "skyblue";
    }   
}