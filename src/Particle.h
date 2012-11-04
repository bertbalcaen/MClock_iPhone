#pragma once

#include "ofMain.h"
#include "ParticleSystem.h"

class ParticleSystem;

/*
Based on code in Daniel Shiffman's seminal Nature of Code book. This is largely based on his Mover class. See http://natureofcode.com/book/chapter-2-forces.
*/
class Particle {

public:

    ParticleSystem* particleSystem;
	ofVec2f pos, vel, accel, grav, textPos;
	float mass;
	string label;
	int age;
	float pendulumAngle;
    
	Particle();
    void setFont(ofTrueTypeFont *font);
	void applyForce(ofVec2f force);
	void update();
	void draw();
	string nf(int num);

private:
    
    ofTrueTypeFont* font;
    
};