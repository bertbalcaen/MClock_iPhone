#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
	ofBackground(255, 255, 255);
	ofEnableAlphaBlending();

    isTouch = false;
    touchStartTime = 0;
    touchDuration = 0;
    
	pendulum.pivotPos.set(ofGetWidth()/2, 0);
    
    setFont("HelveticaNeue-Light.ttf", 26);

    initGui();
    
    showInfoScreen = false;
    
}

//--------------------------------------------------------------
void testApp::update(){
    
    if (!showInfoScreen) {

        pendulum.update();
        
		particleSystem.add(pendulum.bobPos);
        
        particleSystem.update();
        
        if (pendulum.dragged){
            pendulum.angle = atan2(mouseX - pendulum.pivotPos.x, mouseY - pendulum.pivotPos.y);
            pendulum.init();
        }
        
        if(isTouch){
            touchDuration = ofGetElapsedTimef() - touchStartTime;
        } else {
            touchDuration = 0;
        }
        
        if(!gui->isVisible() && touchDuration >= 4 && !pendulum.dragged){
            gui->setVisible(true);
            gui->enable();
        }

    }
    
}

//--------------------------------------------------------------
void testApp::draw(){
	
    if(!showInfoScreen){
    
        pendulum.draw();
        particleSystem.draw();
        
    } else {
        
        drawInfoScreen();
        
    }
    
}

void testApp::setFont(string filename, int size){

    font.loadFont(filename, size);
    particleSystem.font =& font;
    
    string s = "23:59:00";
	pendulum.bobWidth = font.stringWidth(s) * 2;
	pendulum.bobHeight = font.stringHeight(s) * 2;
    
    fontFilename = filename;
    fontSize = size;
    
}

void testApp::setFont(string filename){
    setFont(filename, fontSize);
}

void testApp::setFont(int size){
    setFont(fontFilename, size);
}

void testApp::initGui(){

    gui = new ofxUICanvas(0, 0, ofGetWidth(), ofGetHeight());
    gui->setDrawBack(false);
    gui->setTheme(OFX_UI_THEME_BERLIN);
    gui->setFontSize(OFX_UI_FONT_SMALL, 4);
    gui->setVisible(false);
    gui->disable();
    
    gui->addWidgetDown(new ofxUIFPS(OFX_UI_FONT_SMALL));
    
    gui->addWidgetDown(new ofxUIButton(32, 32, true, "SMURF DEBUG"));
    
    vector<string> fonts;
    fonts.push_back("verdana.ttf");
    fonts.push_back("GUI/NewMedia Fett.ttf");
    fonts.push_back("Arial Narrow.ttf");
    fonts.push_back("BigCaslon.ttf");
    fonts.push_back("Futura-Medium.ttf");
    fonts.push_back("HelveticaNeue-Light.ttf");
    fonts.push_back("HelveticaNeue-Medium.ttf");
    gui->addDropDownList("FONT", fonts, 150);
    
    ofxUISlider * sliderFontSize = new ofxUISlider(150, 16, 4, 48, fontSize, "FONT SIZE");
    gui->addWidgetRight(sliderFontSize);
    
    gui->addWidgetDown(new ofxUIToggle(32, 32, particleSystem.enableParticleScaling, "ENABLE PARTICLE SCALING"));

    gui->addWidgetDown(new ofxUIToggle(32, 32, particleSystem.enableParticleAlpha, "ENABLE PARTICLE ALPHA"));
    
    gui->addWidgetDown(new ofxUIToggle(32, 32, particleSystem.enableParticleColor, "ENABLE PARTICLE COLOR"));
    
    ofxUISlider * sliderParticleGravityY = new ofxUISlider(304, 16, 0.0001, 0.01, particleSystem.particleGravityY, "PARTICLE GRAVITY Y");
    gui->addWidgetDown(sliderParticleGravityY);
    sliderParticleGravityY->setLabelPrecision(8);
    
    gui->addWidgetDown(new ofxUIToggle(32, 32, false, "DRAW PENDULUM BOB"));
    
    ofxUISlider * sliderPendulumArmLength = new ofxUISlider(304, 16, 10, 300, 150, "PENDULUM ARM LENGTH");
    gui->addWidgetDown(sliderPendulumArmLength);
    
    ofxUISlider * sliderPendulumPivotYPos = new ofxUISlider(304, 16, 0, ofGetHeight(), 0.0, "PENDULUM PIVOT Y POS");
    gui->addWidgetDown(sliderPendulumPivotYPos);
    
    ofxUISlider * sliderPendulumDecay = new ofxUISlider(304, 16, 0.9, 0.9999, 0.995, "PENDULUM DECAY");
    gui->addWidgetDown(sliderPendulumDecay);
    sliderPendulumDecay->setLabelPrecision(4);
    
    ofAddListener(gui->newGUIEvent, this, &testApp::guiEvent);
    gui->loadSettings("GUI/guiSettings.xml");
    
}

void testApp::guiEvent(ofxUIEventArgs &e){
    
    if(e.widget->getName() == "PARTICLE GRAVITY Y"){
        ofxUISlider *slider = (ofxUISlider *) e.widget;
        particleSystem.particleGravityY = slider->getScaledValue();
    }
    
    if(e.widget->getName() == "SMURF DEBUG"){
        gui->setVisible(false);
        gui->disable();
    }
    
    if(e.widget->getName() == "ENABLE PARTICLE SCALING"){
        ofxUIToggle *toggle = (ofxUIToggle *) e.widget;
        particleSystem.enableParticleScaling = toggle->getValue();
    }

    if(e.widget->getName() == "ENABLE PARTICLE ALPHA"){
        ofxUIToggle *toggle = (ofxUIToggle *) e.widget;
        particleSystem.enableParticleAlpha = toggle->getValue();
    }
    
    if(e.widget->getName() == "ENABLE PARTICLE COLOR"){
        ofxUIToggle *toggle = (ofxUIToggle *) e.widget;
        particleSystem.enableParticleColor = toggle->getValue();
    }
    
    if(e.widget->getName() == "DRAW PENDULUM BOB"){
        ofxUIToggle *toggle = (ofxUIToggle *) e.widget;
        pendulum.showBob = toggle->getValue();
    }
    
    if(e.widget->getName() == "PENDULUM ARM LENGTH"){
        ofxUISlider *slider = (ofxUISlider *) e.widget;
        pendulum.armLength = slider->getScaledValue();
    }
    
    if(e.widget->getName() == "PENDULUM PIVOT Y POS"){
        ofxUISlider *slider = (ofxUISlider *) e.widget;
        pendulum.pivotPos.y = slider->getScaledValue();
    }
    
    if(e.widget->getName() == "PENDULUM DECAY"){
        ofxUISlider *slider = (ofxUISlider *) e.widget;
        pendulum.decay = slider->getScaledValue();
    }
    
    if(e.widget->getName() == "FONT"){
        ofxUIDropDownList *ddlist = (ofxUIDropDownList *) e.widget;
        vector<ofxUIWidget *> &selected = ddlist->getSelected();
        for(int i = 0; i < selected.size(); i++){
            setFont(selected[i]->getName());
        }
    }

    if(e.widget->getName() == "FONT SIZE"){
        ofxUISlider *slider = (ofxUISlider *) e.widget;
        setFont(slider->getScaledValue());
    }
    
}

void testApp::drawInfoScreen(){
    
    ofSetColor(0);
    ofFill();
    string s = "the\nworld\nneeds\nmore\ndreamers";
    font.drawString(s, 5, 30);
    
}

//--------------------------------------------------------------
void testApp::exit(){

    gui->saveSettings("GUI/guiSettings.xml");
    delete gui;

}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs & touch){

    if (pendulum.inBob(touch.x, touch.y)){
        pendulum.dragged = true;
    }
    
    isTouch = true;
    touchStartTime = ofGetElapsedTimef();
    
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){

    if (pendulum.inBob(touch.x, touch.y)){
        pendulum.dragged = true;
    }
    
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){
    
    pendulum.dragged = false;
    
    isTouch = false;
    
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch){

    if(showInfoScreen){
        string url = "http://theworldneedsmoredreamers.net";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ofxStringToNSString(url)]];
    }
    
    showInfoScreen = !showInfoScreen;

}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void testApp::lostFocus(){

}

//--------------------------------------------------------------
void testApp::gotFocus(){

}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){

}

