window.addEventListener('DOMContentLoaded', init, false);

window.onload = init;


function init() {
    var fieldset = document.getElementsByTagName('input');
    for (var i = 0; i < fieldset.length; i++) {
        fieldset[i].addEventListener('click', toggleInput, false);
    }
}

function toggleInput() {
    var id = this.id;
    switch (id) {
        case "controlToggle": {
            var commas = document.getElementsByClassName("controlToggle");
            for (var i = 0; i < commas.length; i++) {
                commas[i].classList.toggle("on")
            }
        };
        break;
        case "powersToggle": {
            var periods = document.getElementsByClassName("power");
            for (var i = 0; i < periods.length; i++) {
                periods[i].classList.toggle("on")
            }
        };
        break;
    }
}