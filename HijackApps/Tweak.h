#import <UIKit/UIKit.h>

//https://stackoverflow.com/a/5337804
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface UIMutableApplicationSceneClientSettings : NSObject
-(void)setStatusBarAlpha:(double)arg1; // missing on iOS 12, so that's a no-go
-(void)setStatusBarHidden:(BOOL)arg1 ;
@end

@interface FBSScene : NSObject // iOS 14
@property (nonatomic,readonly) UIMutableApplicationSceneClientSettings *clientSettings;
-(void)updateClientSettings:(UIMutableApplicationSceneClientSettings *)settings withTransitionContext:(id)arg2;
@end

@interface FBSSceneImpl : FBSScene // iOS 13
@end

// prefs
static BOOL isEnabled;
