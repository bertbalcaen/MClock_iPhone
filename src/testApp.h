#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "ofxUI.h"

#include "ParticleSystem.h"
#include "Particle.h"
#include "Pendulum.h"

class testApp : public ofxiPhoneApp{
    
    public:
    
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
    
        void setFont(string filename, int size);
        void setFont(string filename);
        void setFont(int size);
    
        void initGui();
        void guiEvent(ofxUIEventArgs &e);
    
        void drawInfoScreen();
    
        ofTrueTypeFont font;
    
        Pendulum pendulum;
        ParticleSystem particleSystem;
    
        ofxUICanvas *gui;
    
        bool isTouch;
        float touchDuration;
        float touchStartTime;
    
        bool showInfoScreen;

    private:
    
        string fontFilename;
        int fontSize;
	
};

