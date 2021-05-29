#import "Tweak.h"

// Lightmann
// Made during covid
// Hijack(Apps)

int callCount;

// get bundleIDs for apps toggled in prefs (applist)
NSArray* getAppPreferences(){
    NSMutableDictionary *appList = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/me.lightmann.hijackprefs.applist.plist"];
    NSMutableArray *appsToHideStatusbar = [NSMutableArray new];
    for(NSString *bundleID in appList) {
        if([[appList objectForKey:bundleID] boolValue]) {
            [appsToHideStatusbar addObject:bundleID];
        }
    }
    return appsToHideStatusbar;
}

%hook SceneClass
-(void)updateClientSettings:(UIMutableApplicationSceneClientSettings *)settings withTransitionContext:(id)arg2 {
	NSArray *appPreferences = getAppPreferences();
	NSString *currentBundleID = [NSBundle mainBundle].bundleIdentifier;

	// this method is called quite a bit, so I'm keeping track of the call count
	// some apps only need it to be called 4 times to hide the statusbar while others need it to be called 7, sooooo 7 it is
	if([appPreferences containsObject:currentBundleID] && callCount <= 6){
		[settings setStatusBarAlpha:0];
		[settings setStatusBarHidden:YES];
		callCount++;
	}

	%orig(settings, arg2);
}
%end;


// PREFERENCES
// Note: checking if(pref){} doesn't work sometimes (returns NO in certain processes), but checking (prefs &&...) works, so . . .
void preferencesChanged(){
	NSDictionary *prefs = [[NSUserDefaults standardUserDefaults] persistentDomainForName:@"me.lightmann.hijackprefs"];
	isEnabled = (prefs && [prefs objectForKey:@"isEnabled"] ? [[prefs objectForKey:@"isEnabled"] boolValue] : YES );
}

%ctor {
	if([[[[NSProcessInfo processInfo] arguments] objectAtIndex:0] containsString:@"/Application"]){
		preferencesChanged();

		if(isEnabled){
			CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)preferencesChanged, CFSTR("me.lightmann.hijackprefs-updated"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);

			NSString *sceneClass = @"FBSSceneImpl";

			if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"14")) {
				sceneClass = @"FBSScene";
			}

			%init(SceneClass = NSClassFromString(sceneClass));
		}
	}
}
