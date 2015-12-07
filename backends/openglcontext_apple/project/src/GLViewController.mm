/*
 * Copyright (c) 2003-2015, GameDuell GmbH
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "openglcontext_ios/GLViewController.h"
#import "openglcontext_ios/GLView.h"
#import "DUELLAppDelegate.h"

static GLViewController *_sharedController = nil;


@implementation GLViewController

- (id)init
{
    NSLog(@"ye");
    self = [super init];
    if (self)
    {}

    _sharedController = self;

    return self;
}

- (void)loadView
{
    NSLog(@"loadView");
    [super loadView];
    self.view = [[GLView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    NSLog(@"%@", self.view);
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [(GLView *)self.view setup];

    #ifndef TARGET_OS_TV
    self.view.multipleTouchEnabled = YES;
    #endif
    self.view.clearsContextBeforeDrawing = NO;
    DUELLAppDelegate *appDelegate = (DUELLAppDelegate *)[[UIApplication sharedApplication] delegate];

    self.view.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    /// set root view for the input later
    appDelegate.rootView = self.view;

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

+ (GLViewController*) sharedController
{
    return _sharedController;
}

- (void)dealloc
{
    [self.view release];

    [super dealloc];
}

@end
