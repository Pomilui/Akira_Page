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
        case "persNameToggle": {
            var commas = document.getElementsByClassName("persName");
            for (var i = 0; i < commas.length; i++) {
                commas[i].classList.toggle("on")
            }
        };
        break;
        case "locToggle": {
            var periods = document.getElementsByClassName("loc");
            for (var i = 0; i < periods.length; i++) {
                periods[i].classList.toggle("on")
            }
        };
        break;
        case "currentToggle": {
            var semicolons = document.getElementsByClassName("current");
            for (var i = 0; i < semicolons.length; i++) {
                semicolons[i].classList.toggle("on")
            }
        };
        break;
        case "dateToggle": {
            var colons = document.getElementsByClassName("date");
            for (var i = 0; i < colons.length; i++) {
                colons[i].classList.toggle("on")
            }
        };
        break;
        case "eventToggle": {
            var colons = document.getElementsByClassName("event");
            for (var i = 0; i < colons.length; i++) {
                colons[i].classList.toggle("on")
            }
        };
        break;
        case "companyToggle": {
            var open_p = document.getElementsByClassName("company");
            for (var i = 0; i < open_p.length; i++) {
                open_p[i].classList.toggle("on")
            }
        };
        break;
    }
}