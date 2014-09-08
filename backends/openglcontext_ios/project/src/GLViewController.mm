#import "openglcontext_ios/GLViewController.h"
#import "openglcontext_ios/GLView.h"

#include <openglcontext_ios/GLTouch.h>

#define TOUCH_LIST_POOL_SIZE 40

@interface GLViewController ()
{
    value touchListPool;

    value touchListToSend;
}

@end

@implementation GLViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        touchListPool = alloc_array(TOUCH_LIST_POOL_SIZE);

        for (int i = 0; i < TOUCH_LIST_POOL_SIZE; i++)
        {
            val_array_set_i(touchListPool, i, openglcontext_ios::GLTouch::createHaxePointer());
        }

        touchListToSend = alloc_array(TOUCH_LIST_POOL_SIZE);
    }
    return self;
}

- (void)loadView
{
    self.view = [[GLView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.multipleTouchEnabled = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [self startAnimation];  // TODO This should be called from the outside
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)startAnimation
{
    [(GLView *)self.view startAnimation];
}

- (void)stopAnimation
{
    [(GLView *)self.view stopAnimation];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (EAGLContext *)getOGLContext
{
    return ((GLView *)self.view).context;
}

- (int)getContextWidth
{
    return ((GLView *)self.view).contextWidth;
}

- (int)getContextHeight
{
    return ((GLView *)self.view).contextHeight;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dispatchTouches:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dispatchTouches:touches];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dispatchTouches:touches];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dispatchTouches:touches];
}

int convertPointerToUniqueInt(void *ptr)
{
    int hash = 16777619; ////FNV PRIME, http://www.isthe.com/chongo/tech/comp/fnv/index.html#FNV-source
    hash ^= (long)ptr;

    return hash;
}

extern void callHaxeOnTouchesCallback(value touchList);
- (void) dispatchTouches:(NSSet *)touches
{
    NSUInteger touchCount = touches.count;

    val_array_set_size(touchListToSend, touchCount);

    int i = 0;
    for (UITouch *touch in touches)
    {
        value glTouchValue = val_array_i(touchListPool, i);
        val_array_set_i(touchListToSend, i, glTouchValue);

        openglcontext_ios::GLTouch *glTouch = (openglcontext_ios::GLTouch *)val_data(glTouchValue);
        CGPoint locationInView = [touch locationInView:self.view];
        glTouch->x = locationInView.x;
        glTouch->y = locationInView.y;
        glTouch->timestamp = touch.timestamp;

        switch(touch.phase)
        {
            case(UITouchPhaseBegan):
                glTouch->state = 0;
                break;
            case(UITouchPhaseMoved):
                glTouch->state = 1;
                break;
            case(UITouchPhaseStationary):
                glTouch->state = 2;
                break;
            case(UITouchPhaseEnded):
                glTouch->state = 3;
                break;
            case(UITouchPhaseCancelled):
                glTouch->state = 3;
        }
        glTouch->id = convertPointerToUniqueInt(touch);

        ++i;
    }

    callHaxeOnTouchesCallback(touchListToSend);
}

- (void)dealloc
{
    [self.view release];
    [super dealloc];
}

@end
