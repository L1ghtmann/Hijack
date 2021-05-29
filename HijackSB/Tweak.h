#import <UIKit/UIKit.h>

@interface UIStatusBar_Modern : UIView
@property (nonatomic,retain) UIView *statusBar;
-(void)doTheThing;
-(void)doTheOtherThing;
@end

@interface SBFolderController : UIViewController
@property (nonatomic,retain) UIStatusBar_Modern *fakeStatusBar;
@end

@interface SBRootFolderController : SBFolderController
@end

// prefs
static BOOL isEnabled;
static BOOL lsStatus;
static BOOL hsStatus;
static BOOL ccStatus;
