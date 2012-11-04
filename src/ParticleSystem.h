#pragma once

#include "ofMain.h"
#include "Particle.h"

class Particle;

class ParticleSystem{
    
public:

	vector<Particle> particles;
    
    ofTrueTypeFont* font;
    
    float particleGravityY;
    bool enableParticleScaling;
    bool enableParticleAlpha;
    bool enableParticleColor;
    
  	ParticleSystem();
	void add(ofVec2f pos);
	void update();
	void draw();

};