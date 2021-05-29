#import "Tweak.h"

// Lightmann
// Made during covid
// Hijack(SB)

// post notifications when CoverSheet is about to be presented or dismissed
%hook CSCoverSheetViewController
-(void)viewWillAppear:(BOOL)animated{
	if(lsStatus){
		[[NSNotificationCenter defaultCenter] postNotificationName:@"onLS_Hijack" object:nil];
	}
	else{
		[[NSNotificationCenter defaultCenter] postNotificationName:@"onLS_Norm" object:nil];
	}

	%orig;
}
-(void)viewWillDisappear:(BOOL)animated{
	if(hsStatus){
		[[NSNotificationCenter defaultCenter] postNotificationName:@"onHS_Hijack" object:nil];
	}
	else{
		[[NSNotificationCenter defaultCenter] postNotificationName:@"onHS_Norm" object:nil];
	}

	%orig;
}
%end

%hook UIStatusBar_Modern
// add observers for notifications
-(void)setStatusBar:(id)bar{
	%orig;

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doTheThing) name:@"onLS_Hijack" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doTheOtherThing) name:@"onLS_Norm" object:nil];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doTheThing) name:@"onHS_Hijack" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doTheOtherThing) name:@"onHS_Norm" object:nil];
}

// respond to notifications
%new
-(void)doTheThing{
	[self.statusBar setAlpha:0];
}

%new
-(void)doTheOtherThing{
	[self.statusBar setAlpha:1];
}
%end

// when a folder is opened, a fake statusbar (i.e., not the system one) is made, so we have to hide it separately
%hook SBRootFolderController
-(void)folderControllerWillOpen:(id)arg1 {
	%orig;

	if(hsStatus) [self.fakeStatusBar setHidden:YES];
}
%end

// cc statusbar
%hook CCUIStatusBar
-(instancetype)initWithFrame:(CGRect)arg1{
	if(ccStatus) return NULL;
	else return %orig;
}
%end


// PREFERENCES
void preferencesChanged(){
	NSDictionary *prefs = [[NSUserDefaults standardUserDefaults] persistentDomainForName:@"me.lightmann.hijackprefs"];
	isEnabled = (prefs && [prefs objectForKey:@"isEnabled"] ? [[prefs objectForKey:@"isEnabled"] boolValue] : YES );
	lsStatus = (prefs && [prefs valueForKey:@"lsStatus"] ? [[prefs valueForKey:@"lsStatus"] boolValue] : NO );
	hsStatus = (prefs && [prefs valueForKey:@"hsStatus"] ? [[prefs valueForKey:@"hsStatus"] boolValue] : NO );
	ccStatus = (prefs && [prefs valueForKey:@"ccStatus"] ? [[prefs valueForKey:@"ccStatus"] boolValue] : NO );
}

%ctor {
	preferencesChanged();

    if(isEnabled){
		CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)preferencesChanged, CFSTR("me.lightmann.hijackprefs-updated"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);

		%init();
	}
}
