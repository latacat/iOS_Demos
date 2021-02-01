//
//  LoginViewController.m
//  AuthCodeTest
//
//  Created by 周永超 on 2021/2/1.
//

#import "LoginViewController.h"
#import "BOUTimerManager.h"

#define ZYC_COLOR_WITH_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnCountDown;

@end

@implementation LoginViewController

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginTimerCountDownCompleted) name:kLoginCountDownCompletedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginTimerCountDownExecutingWithTimeOut:) name:kLoginCountDownExecutingNotification object:nil];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginTimerCountDownCompleted) name:kLoginCountDownCompletedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginTimerCountDownExecutingWithTimeOut:) name:kLoginCountDownExecutingNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.btnCountDown setTitle:@"1111" forState:UIControlStateNormal];
}

#pragma mark - NSNotification 处理倒计时事件

- (void)loginTimerCountDownExecutingWithTimeOut:(NSNotification *)notification {
    NSInteger timeOut = [notification.object integerValue];
    NSString *timeStr = [NSString stringWithFormat:@"(%.2ld)重新获取",(long)timeOut];
    self.btnCountDown.selected = YES;//此处的 self.topView.btnCountDown换成自己的button
    [self.btnCountDown setTitle:timeStr forState:UIControlStateNormal];//此处的 self.topView.btnCountDown换成自己的button
    [self.btnCountDown setTitleColor:ZYC_COLOR_WITH_HEX(0x999999) forState:UIControlStateNormal];
    self.btnCountDown.userInteractionEnabled = NO;
}

- (void)loginTimerCountDownCompleted {
    self.btnCountDown.selected = NO;//此处的 self.topView.btnCountDown换成自己的button
    [self.btnCountDown setTitle:@"获取验证码" forState:UIControlStateNormal];//此处的 self.topView.btnCountDown换成自己的button
    [self.btnCountDown setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];//此处的 self.topView.btnCountDown换成自己的button
    self.btnCountDown.userInteractionEnabled = YES;//此处的 self.topView.btnCountDown换成自己的button
}

#pragma mark - action events

- (IBAction)sendSMSAction:(UIButton *)sender {
    
    [self sendSMSRequestWithPhone:@"" sender:sender];
}

- (IBAction)loginAction:(UIButton *)sender {
    
    [self clickLoginAction:sender];
}

#pragma mark - private method

- (void)sendSMSRequestWithPhone:(NSString *)phoneNum sender:(UIButton *)sender {
    //模拟网络请求
    //...
    //开始倒计时
    [[BOUTimerManager sharedInstance] timerCountDownWithType:BOUCountDownTypeLogin];
}

- (void)clickLoginAction:(UIButton *)sender {
    //模拟网络请求
    //...
    //取消登录界面倒计时
    [[BOUTimerManager sharedInstance] cancelTimerWithType:BOUCountDownTypeLogin];
}

@end
