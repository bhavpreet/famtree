function Branch (begin, end, level) {
	this.begin = begin;
	this.end = end;
	this.level = level;
	this.finished = false;

	this.jitter = function (p) {
		this.end.x += p.random(-0.125,0.125);
		this.end.y += p.random(-0.125,0.125);
	}

	this.show = function (p) {
		//making of the first branch (root)
		p.push();
		p.stroke (0);
		let sWeight = 15 / ((this.level+1) * 0.8); // +1 to acomodate for 0
		p.strokeWeight(sWeight);
		p.line (this.begin.x, this.begin.y, this.end.x, this.end.y);
		p.pop();
	}

	this.branch = function (p, angle, level) {
		//taking the vector angle, but first giving its direction
		var dir = p5.Vector.sub(this.end, this.begin);
		//p5 vector direction has an inbuilt angle
		dir.rotate(angle);
		//making the length shorter than prev one
		dir.mult(0.67);
		//making a new end point for the new branch
		var newEnd = p5.Vector.add(this.end, dir);
		//new branch shares the previous branch's ending point
		//as its starting point plus we just made a new end for it
		//in the previous line

		var b = new Branch (this.end, newEnd, level);
		//console.log(newEnd.x, newEnd.y, leaf.x, leaf.y);
		return b;
	};
}
