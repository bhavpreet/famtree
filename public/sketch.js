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
    }

    p.windowResized = function () {
        gp.resizeCanvas(p.windowWidth, height);
    }

    p.setup = function() {
        p.createCanvas(p.windowWidth, 400);
        // p.createCanvas(400, 400);
        p.textSize(23);


        // vector here stores the start point and end point
        // a vector has magnitude and direction
        var a = p.createVector (p.width/2, p.height); //startpoint
        var b = p.createVector (p.width/2, p.height-100); //endpoint
        var root = new Branch (a, b); //starting first branch line |
        tree[0] = root; //storing the root in the tree array
        tree.push(tree[0].branchL(p))
        treeN.push(tree[tree.length-1]);
        tree.push(tree[0].branchR(p))
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
            //tree[1].show(); //replacing root.show, now array
            //tree[2].show();
            tree[i].show(p);
            // tree[i].jitter(p);
        }

        //root.show();

        for ( var i = 0; i < leaves.length; i++) {
            if (leaves[i].entry.isNew == true) {
                p.stroke(0);
                p.fill(90, 0, 230);
            } else {
                p.noStroke();
                p.fill(245, 156, 67);
            }
            //p.stroke(0);
            p.ellipse (leaves[i].x, leaves[i].y, 8,8); //ellipse diam

            //leaves[i].show();
            let d = p.dist(p.mouseX, p.mouseY, leaves[i].x, leaves[i].y);
            if (d < 5 || leaves[i].entry.isNew == true) {
                p.fill(0);
                p.textAlign(p.CENTER);
                p.textSize(14);
                //p.noStroke();
                p.text(leaves[i].entry.name, leaves[i].x, leaves[i].y + 8 - 20);
                p.fill(234,98,0);
                p.stroke(0);
                p.ellipse(leaves[i].x, leaves[i].y, 8,8);
            }
            
        }
    }
};

new p5(sketch, 'sketchCanvas');

function drawEvenOdd(bnTree, level, entry) {
    if ((bnTree.length - (2 * level + 1)) % 2 == 0) {
        // console.log("even");
        parent = (bnTree.length - 1) / 2;
        // console.log("parent: ", parent);
        // console.log("parent node: ", bnTree[parent]);
        tree.push(bnTree[parent].branchL(gp));
    } else {
        // console.log("odd");
        parent = (bnTree.length - 2) / 2;
        // console.log("parent: ", parent);
        // console.log("parent node: ", bnTree[parent]);
        tree.push(bnTree[parent].branchR(gp));
    }
    bnTree.push(tree[tree.length-1]);
    tree[tree.length-1].entry = entry;
}

function drawBranch(entry, isNew) {    // mouseClick
    // console.log("entry = ", entry.relatedTo);
    if (entry.relatedTo == "Natasha") {
        var maxElems = Math.pow(2, levelN);
        // console.log("maxElems = ", maxElems, "levelN = ", levelN)
        if (treeN.length - (2 * levelN + 1) == maxElems) {
            levelN += 1
        }
        drawEvenOdd(treeN, levelN, entry);
    } else if (entry.relatedTo == "Bhavpreet") {
        var maxElems = Math.pow(2, levelN);
        // console.log("maxElems = ", maxElems, "levelN = ", levelN)
        if (treeB.length - (2 * levelB + 1) == maxElems) {
            levelB += 1
        }
        drawEvenOdd(treeB, levelB, entry);
    }
    var leaf = tree[tree.length-1].end.copy(); 
    entry.isNew = isNew;
    leaf.entry = entry;
    leaves.push(leaf);

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
                  "age" : table.getNum(r,2),
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
