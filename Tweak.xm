// Import Stuff
#import <AudioToolbox/AudioToolbox.h>

// Interfaces
@interface SBRootFolderController : NSObject
-(void)folderControllerShouldBeginEditing:(id)arg1;
@end

@interface SBIconListPageControl : UIView
@end

// SBRootFolderController doesn't have a shared instance,
// so we are "grabbing" it from its init method.

static SBRootFolderController *folderController;

%hook SBRootFolderController
-(id)initWithConfiguration:(id)arg1 {
	folderController = %orig;
	return folderController;
}
%end

%hook SBIconListPageControl
-(void)didMoveToWindow {
	%orig;
	// Add long-press gesture recogniser
	UILongPressGestureRecognizer *wiggleDotsLongPressRecogniser = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(wiggleDotsLongPressDetected:)];
	wiggleDotsLongPressRecogniser.minimumPressDuration = 0.5;
	[self addGestureRecognizer:wiggleDotsLongPressRecogniser];
}
%new
// When the long-press is detected
-(void)wiggleDotsLongPressDetected:(UILongPressGestureRecognizer*)sender {
	// Haptic feedback
	AudioServicesPlaySystemSound(1519);
	// Run folderController's folderControllerShouldBeginEditing method
	[folderController folderControllerShouldBeginEditing:nil];
}
%end
