#import <UIKit/UIKit.h>

@interface UIMutableApplicationSceneClientSettings : NSObject
-(void)setStatusBarAlpha:(double)arg1;
-(void)setStatusBarHidden:(BOOL)arg1 ;
@end

// Note: vers < 14 use FBScene instead (will look into adding support eventually) 
@interface FBSScene : NSObject 
@property (nonatomic,readonly) UIMutableApplicationSceneClientSettings *clientSettings; 
-(void)updateClientSettings:(UIMutableApplicationSceneClientSettings *)settings withTransitionContext:(id)arg2;
@end

// prefs
static BOOL isEnabled;
