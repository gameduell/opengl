#import <UIKit/UIKit.h>

@interface GLView : UIView

@property (readonly, nonatomic, getter=isAnimating) BOOL animating;
@property (nonatomic) NSInteger animationFrameInterval;
@property (readonly) EAGLContext *context; 
@property (readonly, nonatomic) int contextWidth; 
@property (readonly, nonatomic) int contextHeight; 

- (void)startAnimation;
- (void)stopAnimation;
- (void)drawView:(id)sender;

@end
