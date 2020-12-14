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
var count = 0;
var table;
var treeB = [];
var levelB = 0;
var treeN = [];
var levelN = 0;

var height = 400

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
        font = p.loadFont ('Good Brush.otf');
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
        child = p.loadImage("child.png");
        adult = p.loadImage("adult.png");
        elder = p.loadImage("elder.png");
        // vector here stores the start point and end point
        // a vector has magnitude and direction
        var a = p.createVector (p.width/2, p.height); //startpoint
        var b = p.createVector (p.width/2, p.height-100); //endpoint
        var root = new Branch (a, b, null); //starting first branch line |
        tree[0] = root; //storing the root in the tree array
        tree.push(tree[0].branch(p, -p.PI/4));
        treeN.push(tree[tree.length-1]);
        tree.push(tree[0].branch(p, p.PI/6));
        treeB.push(tree[tree.length-1]);

        //var newBranch = root.branch(); //new branch came out of the root
        //tree[1] = newBranch;
        //console.log(tree);
        drawTable(table);
    }


    p.draw = function() {
        p.background(255);
        // showing tree array
        for ( var i = 0; i < tree.length; i++) {
            t = tree[i]
            t.show(p);
        }

        // flowers
        for (var i=3; i < tree.length; i++) {
            let scale = 25;
            t = tree[i];

            dir = p5.Vector.sub(t.end, t.begin);

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
            p.translate(dir.mag()+(scale/2.3), 0);
            p.imageMode(p.CENTER);
            p.rotate(p.PI/2);

            let d = p.dist(p.mouseX, p.mouseY, v0.x*scale*0.75 + t.leaf.x, v0.y*scale*0.75 + t.leaf.y);
            if (d < scale/3 || t.entry.isNew  == true ) {
                p.image(elder, 0, 0, scale * 3, scale * 3);
            } else {
                p.image(elder, 0, 0, scale, scale);
            }

            p.pop();

        }

        // text
        for (var i=3; i < tree.length; i++) {
            let scale = 25;
            t = tree[i];

            dir = p5.Vector.sub(t.end, t.begin);

            let v0 = p.createVector(dir.x, dir.y);
            v0.normalize();
            //v0.mult(2);

            //greenzone
            // p.noStroke();
            // p.fill(2,200,5);
            // p.ellipse(v0.x*scale*0.75 + t.leaf.x, v0.y*scale*0.75 + t.leaf.y, scale/3, scale/3); //green

            //text to be written here

            let d = p.dist(p.mouseX, p.mouseY, v0.x*scale*0.75 + t.leaf.x, v0.y*scale*0.75 + t.leaf.y);
            //console.log (dir.x);
            if (d < scale/3 || t.entry.isNew) {
                p.push();
                p.translate(t.begin.x, t.begin.y);
                p.translate(dir);
                p.fill(0);
                //p.textAlign(p.CENTER);
                p.textSize(14);
                p.noStroke();
                p.textFont(font);

                // p.fill(230,2,45);
                // p.text(t.entry.name, 0, 0);

                // let bbox = font.textBounds(t.entry.name, 10, 30, 12);
                p.fill(255);
                p.stroke(0);
                // p.rect(bbox.x + v0.x*scale*4, bbox.y + v0.y*scale*4, bbox.w, bbox.h);
                // p.fill(0);
                // p.noStroke();

                p.text(t.entry.name, v0.x*scale*2, v0.y*scale*2);
                // p.fill(234,98,0);
                // p.stroke(0);
                // p.ellipse(leaf.x, leaf.y, 8,8);
                p.pop();
            }
        }
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
        angle = -gp.PI/4;
        tree.push(bnTree[parent].branch(gp, angle));
    } else {
        // console.log("odd");
        parent = (bnTree.length - 2) / 2;
        // console.log("parent: ", parent);
        // console.log("parent node: ", bnTree[parent]);
        angle = gp.PI/6;
        tree.push(bnTree[parent].branch(gp, angle));
    }
    bnTree.push(tree[tree.length-1]);
    tree[tree.length-1].entry = entry;
    return angle;
}

function drawBranch(entry) {
    if (entry.relatedTo == "Natasha") {
        var maxElems = Math.pow(2, levelN);
        // console.log("maxElems = ", maxElems, "levelN = ", levelN)
        if (treeN.length - (2 * levelN + 1) == maxElems) {
            levelN += 1
        }
        angle = drawEvenOdd(treeN, levelN, entry);
    } else if (entry.relatedTo == "Bhavpreet") {
        var maxElems = Math.pow(2, levelN);
        // console.log("maxElems = ", maxElems, "levelN = ", levelN)
        if (treeB.length - (2 * levelB + 1) == maxElems) {
            levelB += 1
        }
        angle = drawEvenOdd(treeB, levelB, entry);
    }
    //color code name with alpha, rsvp
    //age
    //add wedding info
    //new entry- new color, details- name

}


// Call Draw branch for each element in the table
function drawTable(table) {
    // console.log("table: ", table);
    for (let r=0; r < table.getRowCount(); r++) {
        entry = { "name" : table.getString(r, 0),
                  "relation" : table.getString(r,1),
                  "age" : table.getString(r,2),
                  "relatedTo" : table.getString(r,3),
                  "rsvp" : table.getString(r,4)
                };
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
