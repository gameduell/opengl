#import "GLViewController.h"
#import "GLView.h"

@implementation GLViewController

- (void)loadView
{
    self.view = [[GLView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
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

- (void)dealloc
{
    [self.view release];
    [super dealloc];
}

@end
