window.addEventListener('DOMContentLoaded',init,false);

function init() {
    alert ('Hi there! Looks like the page loaded! Yay!');
    var buttons = document.getElementsByTagName("button")
buttons[0].addEventListener('click', changeColor,false)
buttons[1].addEventListener('click', changeColor2, false)
buttons[2].addEventListener('click', changeButton, false)
}


function changeColor() {
var p1 = document.getElementById("colorToggle")
{p1.style.backgroundColor = "skyblue";}
}

function changeColor2() {
var pars = document.getElementsByTagName('p')
    for (var i = 0, length = pars.length; i < length; i++) {
        pars[i].style.backgroundColor = "pink";
    }   
}

function changeButton() {
var li = document.getElementsByTagName('li')
    for (var i = 0, length = li.length; i < length; i++) {
        li[i].style.backgroundColor = "gold";
    }
}