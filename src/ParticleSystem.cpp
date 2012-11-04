#include "ParticleSystem.h"

ParticleSystem::ParticleSystem(){

    particleGravityY = 0.0016;
    
    enableParticleScaling = true;
    enableParticleAlpha = true;
    enableParticleColor = true;

}

void ParticleSystem::add(ofVec2f vec){

	Particle particle;
	particle.pos.x = vec.x;
	particle.pos.y = vec.y;
//	particle.grav.y = map(abs(pendulum.angleVel), 0.1, 3, 0.1, 0.5);
    particle.particleSystem = this;
    particle.setFont(font);
	particles.push_back(particle);

}

void ParticleSystem::update(){

    vector<Particle>::iterator it;
    for(it = particles.begin(); it != particles.end(); ){
        if(it->pos.y > ofGetHeight()){
//            delete it;
            it = particles.erase(it);
        } else {
            ++it;
        }
    }

	for(int i = 0; i < particles.size(); i ++){
//		ofVec2f gravity = ofVec2f(0, map(abs(pendulum.angleVel), 0, 3, 0.01, 1.5));
        ofVec2f gravity = ofVec2f(0, particleGravityY);
		particles[i].applyForce(gravity);
		particles[i].update();
	}

}

void ParticleSystem::draw(){

	for(Particle particle : particles){
		particle.draw();
	}

}