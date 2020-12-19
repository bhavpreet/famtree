import p5 from 'p5';

import footerBgLeft from "../public/invitation-footer-left-min.webp";
import footerBgRight from "../public/invitation-footer-right-min.webp";
import goodBrushFontFile from '../public/Good Brush.otf';
import Branch from "./branch.js";
import addSoundFile from "../public/button-37.wav"
//Based on Daniel Shiffman's Object Oriented tree generation

//family tree forming for Nat and Bhav
//to-do: n
// 1.basic tree branching with inputs/mouse click
// 2.publish on web, html (done: localhost)
// 3.input field, show when hover
// 4.define input fields, eg. color code as per age
var gp;
var tree = [];
var leaves = [];
var table;
var treeB = [];
var levelB = 2;
var treeN = [];
var levelN = 2;

var height = 400
let addEntrySound;
let child;
let adult;
let elder;
let eldest;
let goodBrushFont

export default drawBranch

let sketch = function(p) {
    gp = p;
    //level of interaction : keypress n and b

    //var angle = PI/4; //45 degree
    //var len = 50;
    //var root;

    //instead of making a root, making an array of tree and storing
    //the root and other branch values in the array

    p.preload = function() {
        table = p.loadTable('https://docs.google.com/spreadsheets/d/1ugOJeRIHwUR36fp1-MawZqqw1_X29q4nrLiKM_gu9FI/gviz/tq\?tqx\=out:csv\&sheet\=Sheet1', 'csv', 'header');
        goodBrushFont = p.loadFont (goodBrushFontFile);
        // p5.soundFormats('mp3');
        // addEntrySound = p.loadSound('button-37');
        addEntrySound = new Audio(addSoundFile);
    }

    p.windowResized = function () {
        gp.resizeCanvas(p.windowWidth, p.windowHeight / 1.5);
        gp.redraw();
    }

    p.setup = function() {
        p.createCanvas(p.windowWidth, p.windowHeight / 1.5);
        // p.createCanvas(400, 400);
        p.textSize(23);

        // Load PNGs
        child = p.loadImage("04_young-min.png");
        adult = p.loadImage("03_adult-min.png");
        elder = p.loadImage("02_elder-min.png");
        eldest = p.loadImage("01_eldest-min.png");
        // vector here stores the start point and end point
        // a vector has magnitude and direction
        var a = p.createVector (p.width/2, p.height); //startpoint
        var b = p.createVector (p.width/2, p.height - (p.height / 4.5)); //endpoint
        var root = new Branch (a, b, 0); //starting first branch line |
        tree[0] = root; //storing the root in the tree array
        tree.push(tree[0].branch(p, -p.PI/4.5, 1));
        tree[tree.length-1].entry = makeEntry(0);
        treeN.push(tree[tree.length-1]);
        tree.push(tree[0].branch(p, p.PI/4.5, 1));
        tree[tree.length-1].entry = makeEntry(1);
        treeB.push(tree[tree.length-1]);

        //var newBranch = root.branch(); //new branch came out of the root
        //tree[1] = newBranch;
        //console.log(tree);
        drawTable(table);
    }


    p.draw = function() {
        p.background(255);
        let t;
        // showing tree array
        for ( var i = 0; i < tree.length; i++) {
            t = tree[i]
            t.show(p);
        }

        // flowers
        for (var i=1; i < tree.length; i++) {
            let scale = 35;
            t = tree[i];

            let dir = p5.Vector.sub(t.end, t.begin);

            let v0 = p.createVector(dir.x, dir.y);
            v0.normalize();
            //v0.mult(2);

            // p.fill(230,2,45);
            // p.noStroke();
            // p.ellipse(t.leaf.x,t.leaf.y, 5, 5); //red

            //flowers to be written here

            p.push();
            p.translate(t.begin.x, t.begin.y);
            p.rotate(dir.heading());
            p.translate(dir.mag()+(scale/2.1), 0);
            p.imageMode(p.CENTER);
            p.rotate(p.PI/2);

            //ageGroup = [ "Young at 💖", "Above 50", "30-50", "20-30", "< 20"]

            let img = child;
            if (t.entry.age  == "Young at 💖" ) {
                img = child;
            } else if (t.entry.age  == "Above 50" ) {
                img = eldest;
            } else if (t.entry.age  == "30-50" ) {
                img = elder;
            } else if (t.entry.age  == "20-30" ) {
                img = adult;
            } else if (t.entry.age  == "< 20"){
                img = child;
            }

            let d = p.dist(p.mouseX, p.mouseY, v0.x*scale*0.75 + t.end.x, v0.y*scale*0.75 + t.end.y);
            if (d < scale/2 || t.entry.isNew  == true ) {
                p.image(img, 0, 0, scale * 2.1, scale * 2.1);
            } else {
                p.image(img, 0, 0, scale, scale);
            }

            p.pop();

        }

        // text
        for (var i=1; i < tree.length; i++) {
            let scale = 35;
            let t = tree[i];

            let dir = p5.Vector.sub(t.end, t.begin);

            let v0 = p.createVector(dir.x, dir.y);
            v0.normalize();
            //v0.mult(2);

            //greenzone
            // p.noStroke();
            // p.fill(2,200,5);
            // p.ellipse(v0.x*scale*0.75 + t.leaf.x, v0.y*scale*0.75 + t.leaf.y, scale/3, scale/3); //green

            //text to be written here

            let d = p.dist(p.mouseX, p.mouseY, v0.x*scale*0.75 + t.end.x, v0.y*scale*0.75 + t.end.y);
            //console.log (dir.x);
            if (d < scale/2 || t.entry.isNew) {
                p.push();
                p.translate(t.begin.x, t.begin.y);
                p.translate(dir);
                p.fill(0);
                //p.textAlign(p.CENTER);
                p.textSize(18);
                // p.noStroke();
                p.textFont(goodBrushFont);
                p.textLeading(120);
                p.fill(255);
                p.stroke(0);
                if (p.width > 600) {
                    p.textAlign(p.CENTER);
                    p.text(t.entry.name, v0.x*scale*2, v0.y*scale*2);
                } else {
                    // if (t.entry.relatedTo == "Natasha") {
                    //     p.textAlign(p.LEFT);
                    // } else {
                    //     p.textAlign(p.RIGHT);
                    // }
                    p.textAlign(p.CENTER);
                    p.text(t.entry.name, v0.x, v0.y * scale * 2);
                }
                p.pop();
            }
        }
		// p.noLoop();
    }
};

new p5(sketch, 'sketchCanvas');

// draw an arrow for a vector at a given base position
function drawArrow(base, vec, myColor) {
  gp.push();
  gp.stroke(myColor);
  gp.strokeWeight(3);
  gp.fill(myColor);
  gp.translate(base.x, base.y);
  gp.line(0, 0, vec.x, vec.y);
  gp.rotate(vec.heading());
  let arrowSize = 7;
  gp.translate(vec.mag() - arrowSize, 0);
  gp.triangle(0, arrowSize / 2, 0, -arrowSize / 2, arrowSize, 0);
  gp.pop();
}

function drawEvenOdd(bnTree, level, entry) {
    let angle = 0;
    if ((bnTree.length - (2 * level + 1)) % 2 == 0) {
        // console.log("even");
        parent = (bnTree.length - 1) / 2;
        // console.log("parent: ", parent);
        // console.log("parent node: ", bnTree[parent]);
        angle = -gp.PI/4.5;
        tree.push(bnTree[parent].branch(gp, angle, level));
    } else {
        // console.log("odd");
        parent = (bnTree.length - 2) / 2;
        // console.log("parent: ", parent);
        // console.log("parent node: ", bnTree[parent]);
        angle = gp.PI/5.5;
        tree.push(bnTree[parent].branch(gp, angle, level));
    }
    tree[tree.length-1].entry = entry;
    tree[tree.length-1].level = level;
    // console.log("Level = ", level);
    bnTree.push(tree[tree.length-1]);
    return angle;
}

function drawBranch(entry) {
    if (entry.relatedTo == "Natasha") {
        var maxElems = Math.pow(2, levelN);
        let angle = drawEvenOdd(treeN, levelN, entry);
        if (treeN.length + 1 == maxElems) { // +1 to acomodated for predrawn node 
            levelN += 1
        }
        // console.log("maxElems = ", maxElems, "levelN = ", levelN);
    } else if (entry.relatedTo == "Bhavpreet") {
        var maxElems = Math.pow(2, levelB) ;
        let angle = drawEvenOdd(treeB, levelB, entry);
        if (treeB.length + 1== maxElems) { // +1 to acomodated for predrawn node 
            levelB += 1
            // console.log("Updateing levelB= ", levelB);
        }
        // console.log("maxElems = ", maxElems, "levelB = ", levelB, "lenB = ", treeB.length);
    }

    if (entry.isNew == true) {
        addEntrySound.play();
    }
    //color code name with alpha, rsvp
    //age
    //add wedding info
    //new entry- new color, details- name

}

function makeEntry(r) {
    return { "name" : table.getString(r, 0),
             "relation" : table.getString(r,1),
             "age" : table.getString(r,2),
             "relatedTo" : table.getString(r,3),
             "rsvp" : table.getString(r,4)
           };
    
}

// Call Draw branch for each element in the table
function drawTable(table) {
    // console.log("table: ", table);
    for (let r=2; r < table.getRowCount(); r++) { // 0, 1 are populated at the root level
        let entry = makeEntry(r);
        drawBranch(entry, false);
    }
}


// Save
function saveToFamTree(name, relation) {
    const Http = new XMLHttpRequest();
    const url = 'https://script.google.com/macros/s/AKfycbzfGamhVtRvxDPyiqf9yofRX-GdJYGd6HzSx6sITtlgmQv0aJ0/exec?'
    Http.open("GET", url + "col1=" + name + "&col2=" + relation);
    Http.send();

    Http.onreadystatechange = (e) => {
        console.log(Http.responseText)
    }
}
