//family tree forming for Nat and Bhav
//to-do: 
// 1.basic tree branching with inputs/mouse click
// 2.publish on web, html (done: localhost)
// 3.input field, show when hover
// 4.define input fields, eg. color code as per age

//var angle = PI/4; //45 degree
var len = 50;

let table;

function preload() {
  //my table is comma separated value "csv"
  //and has a header specifying the columns labels
  table = loadTable('https://docs.google.com/spreadsheets/d/1ugOJeRIHwUR36fp1-MawZqqw1_X29q4nrLiKM_gu9FI/gviz/tq\?tqx\=out:csv\&sheet\=Bhav', 'csv', 'header');
  //the file can be remote
  //table = loadTable("http://p5js.org/reference/assets/mammals.csv",
  //                  "csv", "header");
}

function saveToFamTree(name, relation) {
  const Http = new XMLHttpRequest();
  const url = 'https://script.google.com/macros/s/AKfycbzfGamhVtRvxDPyiqf9yofRX-GdJYGd6HzSx6sITtlgmQv0aJ0/exec?'
  Http.open("GET", url + "col1=" + name + "&col2=" + relation);
  Http.send();

  Http.onreadystatechange = (e) => {
    console.log(Http.responseText)
  }
}

function setup() {
  createCanvas(400, 400);
  background(220);
  textSize(23);
   //fill(255, 20, 145);
  for (let r=0; r < table.getRowCount(); r++) {
    const name = table.getString(r, 0);
    const rel = table.getString(r, 1);

    console.log(name, rel);
  }
}

function draw() {
  //background(210);
  //push();
  translate(width/2, height);
  //branch (70); 
  line(0, 0, 0, -len);
  // if (mouseIsPressed){
  //   translate(0,-len);
  //   rotate(PI/4);
  //   line(0,0, 0, -len*0.68);
  //   fill(224, 170, 241);
  //   ellipse (0,-len*0.68, 15,15);
  // }
  //pop();
  if((key=='B')||(key=='b'))
    {
      text(key, 10, -10);
    } else
  if((key=='N')||(key=='n'))
    {
      text(key, -20, -10);
    }
}

function keyPressed () {
  if((keyIsPressed==true) && ((key=='N')||(key=='n'))){
    fill(224, 110, 241); //peach
    translate(0,-len);
    rotate(PI/4);
    line(0,0, 0, -len*0.68);
    //ellipse(0, -len*0.68, 10,10);
    rect (0, -len*0.68, 10,10);
    //rotate(PI);
    len = len*0.98 + 20;
    print (key, ''); //count number of key 'n' presses
  } else if ((keyIsPressed==true) && ((key=='B')||(key=='b'))){
    fill(120, 170, 11); //green
    translate(0,-len);
    rotate(PI/1.3);
    line(0,0, 0,len*0.98);
    ellipse(0,len*0.98, 10,10);
    //translate(0,0);
    len = len*0.98 + 10;
    print (key, ''); //count number of key 'b' presses
}
//BRANCHING
}

// function mousePressed () {
//   //fill(0);
//   //ellipse(mouseX, mouseY, 50,50);

// if (mouseX<width/2 && mouseY<height) { //mouse pressed in first half
//   fill(224, 170, 241);
//   ellipse(mouseX, mouseY, 10,10);
//   //instead of ellipse, draw a line, branching on the left
//   line(width/2, -len ,width,len*8);
// } else {   //mouse pressed in second half
//   fill(255, 120, 145);
//   rect(mouseX, mouseY, 10,10);
//   line(mouseX, mouseY,0,len*8);
// }
// return(false);

// }

// function branch (len) {
//   stroke(200);
//   line (0,0,0,-len);
//   translate (0,-len);
//   rotate (PI/4);
//   if (mouseIsPressed == true && mouseX<200 && mouseY<400){
//   console.log();
//   branch(len*0.7);
// }

// }
  // line (0,0,0,-len*0.67);
  // rotate (-PI/3);
  //branch(len*0.67);
  // if (mouseIsPressed==true){
  //     branch(len*0.7);
  //     } 

      //with every mouse press, branch one next
      //with mouse press in first half of x, branch left
      //with mouse press in second half of x, branch right
      //with double click two branches from one 






