#include "AppDelegate.h"
#include "CCLuaEngine.h"
#include "SimpleAudioEngine.h"
#include "cocos2d.h"

using namespace CocosDenshion;

USING_NS_CC;
using namespace std;

AppDelegate::AppDelegate()
{

}

AppDelegate::~AppDelegate()
{
    SimpleAudioEngine::end();
}

bool AppDelegate::applicationDidFinishLaunching()
{
    // initialize director
    auto director = Director::getInstance();
	auto glview = director->getOpenGLView();
	if(!glview) {
		glview = GLView::createWithRect("CocoLink", Rect(0,0,568,320));
		director->setOpenGLView(glview);
	}

    glview->setDesignResolutionSize(1136, 641, ResolutionPolicy::SHOW_ALL);

    // turn on display FPS
    director->setDisplayStats(true);

    // set FPS. the default value is 1.0/60 if you don't call this
    director->setAnimationInterval(1.0 / 60);


	auto engine = LuaEngine::getInstance();
	ScriptEngineManager::getInstance()->setScriptEngine(engine);

	auto fileUtils = FileUtils::getInstance();
	std::vector<std::string> SearchPaths =fileUtils->getSearchPaths();
	SearchPaths.insert(SearchPaths.begin(),"res");
	FileUtils::getInstance()->setSearchPaths(SearchPaths);


	engine->executeScriptFile("src/main.lua");

    return true;
}

// This function will be called when the app is inactive. When comes a phone call,it's be invoked too
void AppDelegate::applicationDidEnterBackground()
{
    Director::getInstance()->stopAnimation();

    SimpleAudioEngine::getInstance()->pauseBackgroundMusic();
}

// this function will be called when the app is active again
void AppDelegate::applicationWillEnterForeground()
{
    Director::getInstance()->startAnimation();

    SimpleAudioEngine::getInstance()->resumeBackgroundMusic();
}
