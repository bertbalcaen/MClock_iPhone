#include "Particle.h"

Particle::Particle() {
    
	mass = 1;
	age = 0;

	pos.set(0, 0);
	vel.set(0, 0);
	accel.set(0, 0);
	grav.set(0, 0.1);

	label = nf(ofGetHours()) + ":" + nf(ofGetMinutes()) + ":" + nf(ofGetSeconds());

}

void Particle::setFont(ofTrueTypeFont *_font){

    font = _font;
    textPos.x = - (*font).stringWidth(label) / 2;
    textPos.y = (*font).stringHeight(label);
    
}

void Particle::applyForce(ofVec2f force) {

	ofVec2f f = force / mass;
	accel += f;

}

void Particle::update() {

	vel += accel;
	pos += vel;

	age ++;

}

void Particle::draw() {

//	float alpha = ofMap(age, 0, 800, 100, 0);
    float alpha = 100;
    if((*particleSystem).enableParticleAlpha){
        alpha = ofMap(pos.y, 100, ofGetHeight(), 100, 0);
    }
    
    float grey = 0;
    if((*particleSystem).enableParticleColor){
        grey = ofMap(pos.y, 100, ofGetHeight(), 0, 200);
        ofSetColor(grey);
    } else {
        grey = 0;
    }
    
    ofSetColor(grey, alpha);
	ofFill();
    
	ofPushMatrix();
    ofTranslate(pos);

    if((*particleSystem).enableParticleScaling){
        float scaleFactor = ofMap(pos.y, 100, ofGetHeight(), 1, 0);
        scaleFactor = ofClamp(scaleFactor, 0, 1);
        ofScale(scaleFactor, scaleFactor);
    }
    
    (*font).drawString(label, textPos.x, textPos.y);
    
	ofPopMatrix();

}

string Particle::nf(int num){
    if(num <= 9){
        return "0" + ofToString(num);
    } else {
        return ofToString(num);
    }
}