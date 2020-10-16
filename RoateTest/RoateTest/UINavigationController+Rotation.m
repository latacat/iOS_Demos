//
//  UINavigationController+Rotation.m
//  RoateTest
//
//  Created by 周永超 on 2020/3/20.
//  Copyright © 2020 周永超. All rights reserved.
//

#import "UINavigationController+Rotation.h"


@implementation UINavigationController (Rotation)

- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

@end
