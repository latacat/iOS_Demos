//
//  BOUTimerManager.m
//  AuthCodeTest
//
//  Created by 周永超 on 2021/2/1.
//

#import "BOUTimerManager.h"

#define kMaxCountDownTime           60//倒计时时间，可自定义

@interface BOUTimerManager ()

@property (nonatomic, assign) BOUCountDownType countDonwnType;

@property (nonatomic, nullable, strong) dispatch_source_t loginTimer;//登录界面倒计时timer

@property (nonatomic, nullable, strong) dispatch_source_t findPwdTimer;//找回密码界面倒计时timer

@property (nonatomic, nullable, strong) dispatch_source_t registerTimer;//注册界面倒计时timer

@property (nonatomic, nullable, strong) dispatch_source_t modifyPhoneTimer;//修改手机号界面倒计时timer

@end

@implementation BOUTimerManager

IMP_SINGLETON(BOUTimerManager);

- (void)timerCountDownWithType:(BOUCountDownType)countDownType {
    
    _countDonwnType = countDownType;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    
    NSTimeInterval seconds = kMaxCountDownTime;
    NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:seconds];
    dispatch_source_set_event_handler(_timer, ^{
    
        int interval = [endTime timeIntervalSinceNow];
        if (interval <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if ([_timer isEqual:self.loginTimer]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginCountDownCompletedNotification object:@(interval)];
                } else if ([_timer isEqual:self.findPwdTimer]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kFindPasswordCountDownCompletedNotification object:@(interval)];
                } else if ([_timer isEqual:self.registerTimer]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kRegisterCountDownCompletedNotification object:@(interval)];
                } else if ([_timer isEqual:self.modifyPhoneTimer]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kModifyPhoneCountDownCompletedNotification object:@(interval)];
                }
            
            });
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if ([_timer isEqual:self.loginTimer]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginCountDownExecutingNotification object:@(interval)];
                } else if ([_timer isEqual:self.findPwdTimer]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kFindPasswordCountDownExecutingNotification object:@(interval)];
                } else if ([_timer isEqual:self.registerTimer]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kRegisterCountDownExecutingNotification object:@(interval)];
                } else if ([_timer isEqual:self.modifyPhoneTimer]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kModifyPhoneCountDownExecutingNotification object:@(interval)];
                }
                
            });
        }
    });
    
    if (self.countDonwnType == BOUCountDownTypeLogin) {
        self.loginTimer = _timer;
    } else if (self.countDonwnType == BOUCountDownTypeFindPassword) {
        self.findPwdTimer = _timer;
    } else if (self.countDonwnType == BOUCountDownTypeRegister) {
        self.registerTimer = _timer;
    } else if (self.countDonwnType == BOUCountDownTypeModifyPhone) {
        self.modifyPhoneTimer = _timer;
    }
    
    dispatch_resume(_timer);
}

- (void)cancelTimerWithType:(BOUCountDownType)countDownType {
    switch (countDownType) {
        case BOUCountDownTypeLogin:
            if (self.loginTimer) {
                dispatch_source_cancel(self.loginTimer);
                self.loginTimer = nil;
            }
            
            break;
        case BOUCountDownTypeRegister:
            if (self.registerTimer) {
                dispatch_source_cancel(self.registerTimer);
                self.registerTimer = nil;
            }
            
            break;
        case BOUCountDownTypeModifyPhone:
            if (self.registerTimer) {
                dispatch_source_cancel(self.modifyPhoneTimer);
                self.registerTimer = nil;
            }
            
            break;
        case BOUCountDownTypeFindPassword:
            if (self.registerTimer) {
                dispatch_source_cancel(self.findPwdTimer);
                self.registerTimer = nil;
            }
            
            break;
        default:
            break;
    }
}

@end
