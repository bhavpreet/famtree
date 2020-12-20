import './main.css';
import { Elm } from './Main.elm';
import * as serviceWorker from './serviceWorker';

// Images
import headerBgRight from "../public/invitation-header-right-min.png"
import footerBgLeft from "../public/invitation-footer-left-min.png"
import footerBgRight from "../public/invitation-footer-right-min.png"

require("material-components-web-elm/dist/material-components-web-elm.js");
require("material-components-web-elm/dist/material-components-web-elm.css");
require("p5");
require("./branch.js");
require("./sketch.js");
import drawBranch from "./sketch.js";

var app = Elm.Main.init({
  node: document.getElementById('root')
  , flags: {
    window : {
      width: window.innerWidth,
      height: window.innerHeight
    },
    assets : {
      headerBgRight: headerBgRight,
      footerBgLeft: footerBgLeft,
      footerBgRight: footerBgRight
    }
  }
});

app.ports.drawBranch.subscribe(function(model) {
  drawBranch(model, true);
});

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();

export default app
