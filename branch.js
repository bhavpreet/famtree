function Branch (begin, end) {
	this.begin = begin;
	this.end = end;
	this.finished = false;

	this.jitter = function () {
		this.end.x += random(-0.125,0.125);
		this.end.y += random(-0.125,0.125);
	}

	this.show = function () {
		//making of the first branch (root)
		stroke (0);
		strokeWeight(2);
		line (this.begin.x, this.begin.y, this.end.x, this.end.y);
	}

	this.branchN = function () {
		//taking the vector angle, but first giving its direction
		var dir = p5.Vector.sub(this.end, this.begin);
		//p5 vector direction has an inbuilt angle
		dir.rotate(PI/6);
		//making the length shorter than prev one
		dir.mult(0.67);
		//making a new end point for the new branch
		var newEnd = p5.Vector.add(this.end, dir);
		//new branch shares the previous branch's ending point 
		//as its starting point plus we just made a new end for it
		//in the previous line
		var b = new Branch (this.end, newEnd);
		return b;
	};

	this.branchB = function () {
	
		var dir = p5.Vector.sub(this.end, this.begin);
		dir.rotate(-PI/4);
		dir.mult(0.67);
		var newEnd = p5.Vector.add(this.end, dir);
		var b = new Branch (this.end, newEnd);
		return b;
	};

}