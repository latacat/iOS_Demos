//
//  UITabBarController+Rotation.m
//  RoateTest
//
//  Created by 周永超 on 2020/3/20.
//  Copyright © 2020 周永超. All rights reserved.
//

#import "UITabBarController+Rotation.h"


@implementation UITabBarController (Rotation)

- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

@end
