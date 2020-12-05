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

        //var newBranch = root.branch(); //new branch came out of the root
        //tree[1] = newBranch;
        //console.log(tree);
        drawTable(table);
    }

    // p.mouseClicked = function() {
    //     for (var i = tree.length-1; i >= 0; i--) {
    //         if (!tree[i].finished) {
    //             tree.push(tree[i].branchN(gp)); //add an array to the tree by .push
    //             tree.push(tree[i].branchB(gp));
    //         }
    //         tree[i].finished = true;
    //     }
    //     count++;

    //     if (count === 4) {
    //         for ( var i = 0; i< tree.length; i++) {
    //             if (!tree[i].finished){
    //                 var leaf = tree[i].end.copy(); //grab end point of branch for the leaf
    //                 leaves.push(leaf);
    //             }
    //         }
    //     }
    // }

    // tree[1] = tree[0].branchN(); //instead of root.branchA, since tree[0] global
    // tree[2] = tree[0].branchB();


    p.draw = function() {

        p.background(220);

        // showing tree array
        for ( var i = 0; i < tree.length; i++) {
            //tree[1].show(); //replacing root.show, now array
            //tree[2].show();
            tree[i].show(p);
            // tree[i].jitter(p);
        }

        //root.show();

        for ( var i = 0; i < leaves.length; i++) {
            p.fill(245, 156, 67);
            p.ellipse (leaves[i].x, leaves[i].y, 8,8);
            //leaves[i].show();
        }
    }
};

new p5(sketch, 'sketchCanvas');

function drawBranch(model) {    // mouseClick
    for (var i = tree.length-1; i >= 0; i--) {
        if (!tree[i].finished) {
            tree.push(tree[i].branchN(gp)); //add an array to the tree by .push
            tree.push(tree[i].branchB(gp));
        }
        tree[i].finished = true;
    }
    count++;

    if (count === 4) {
        for ( var i = 0; i< tree.length; i++) {
            if (!tree[i].finished){
                var leaf = tree[i].end.copy(); //grab end point of branch for the leaf
                leaves.push(leaf);
            }
        }
    }
}

// Call Draw branch for each element in the table
function drawTable(table) {
    console.log("table: ", table);
    for (let r=0; r < table.getRowCount(); r++) {
        model = { "name" : table.getString(r, 0),
                  "relation" : table.getString(r,1),
                  "age" : table.getNum(r,2),
                  "realtedTo" : table.getString(r,3),
                  "rsvp" : table.getString(r,4)
                };
        drawBranch(model);
    }
}

//with every mouse press, branch one next
//with mouse press in first half of x, branch left
//with mouse press in second half of x, branch right
//with double click two branches from one


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
