#include "Pendulum.h"

Pendulum::Pendulum() {

	pivotPos.set(0, 0);
	bobPos.set(0, 0);
    
    armLength = 200;
    
    decay = 0.995;

	angle = 0; // PI/2
    
    showBob = false;

	init();

}

void Pendulum::init(){
	angleVel = 0.0;
	angleAccel = 0.0;
}

void Pendulum::update() {

	float gravity = 0.4;
	angleAccel = (-1 * gravity / armLength) * sin(angle);

	angleVel += angleAccel;
	angle += angleVel;

	angleVel *= decay;

	bobPos.x = armLength * sin(angle);
	bobPos.y = armLength * cos(angle);
	bobPos += pivotPos;

}

void Pendulum::draw() {

    ofSetColor(0);
	ofLine(pivotPos.x, pivotPos.y, bobPos.x, bobPos.y);
    
    if(showBob){
        drawBob();
    }

}

bool Pendulum::inBob(float x, float y){
	return x > bobPos.x - bobWidth/2 && x < bobPos.x + bobWidth/2 && y > bobPos.y - bobHeight/2 && y < bobPos.y + bobHeight/2;
}

void Pendulum::drawBob(){
    ofRect(bobPos.x - bobWidth/2, bobPos.y - bobHeight/2, bobWidth, bobHeight);    
}