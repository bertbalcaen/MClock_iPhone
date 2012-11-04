#pragma once

#include "ofMain.h"

/*
Based on code in Daniel Shiffman's seminal Nature of Code book. This is a slightly modified version of his Pendulum class. See http://natureofcode.com/book/chapter-3-oscillation#39-trigonometry-and-forces-the-pendulum.
*/
class Pendulum	{

public:
	ofVec2f pivotPos, bobPos;
    
    float armLength;

	float angle;
	float angleVel;
	float angleAccel;

	float decay;

	float bobWidth, bobHeight;
    bool showBob;

	bool dragged = false;

	Pendulum();
	void init();
	void update();
	void draw();
	bool inBob(float x, float y);
    void drawBob();

};