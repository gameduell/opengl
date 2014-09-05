#import <UIKit/UIKit.h>

@interface GLViewController : UIViewController

- (void)startAnimation;
- (void)stopAnimation;

- (EAGLContext *)getOGLContext;
- (int)getContextWidth;
- (int)getContextHeight;

@end
