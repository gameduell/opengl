#import "openglcontext_ios/GLViewController.h"
#import "openglcontext_ios/GLView.h"


@implementation GLViewController

- (id)init
{
    self = [super init];
    if (self)
    {}

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

- (EAGLContext *)context
{
    return ((GLView *)self.view).context;
}

- (int)contextWidth
{
    return ((GLView *)self.view).contextWidth;
}

- (int)contextHeight
{
    return ((GLView *)self.view).contextHeight;
}

- (void)dealloc
{
    [self.view release];
    
    [super dealloc];
}

@end
