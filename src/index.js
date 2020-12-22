import './main.css';
import { Elm } from './Main.elm';
import * as serviceWorker from './serviceWorker';

// Images
import headerBgRight from "../public/invitation-header-right-min-400w.png"
import footerBgLeft from "../public/invitation-footer-left-min-400w.png"
import footerBgRight from "../public/invitation-footer-right-min-400w.png"
import eldest from "../public/01_eldest-min.png"
import elder from "../public/02_elder-min.png"
import adult from "../public/03_adult-min.png"
import child from "../public/04_young-min.png"


require("material-components-web-elm/dist/material-components-web-elm.js");
require("material-components-web-elm/dist/material-components-web-elm.css");
// import drawBranch from "./sketch.js";
import (/* webpackPrefetch: true */ "./sketch.js");

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
      footerBgRight: footerBgRight,
      eldest: eldest,
      elder: elder,
      adult: adult,
      child: child
    }
  }
});

app.ports.drawBranch.subscribe(function(model) {
  // drawBranch(model, true);
});

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();

export default app
