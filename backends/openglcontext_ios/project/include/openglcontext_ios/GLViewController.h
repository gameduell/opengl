#import <UIKit/UIKit.h>


@interface GLViewController : UIViewController

@property (nonatomic, readonly, strong) EAGLContext *context;

- (void)startAnimation;
- (void)stopAnimation;

- (int)contextWidth;
- (int)contextHeight;

@end
