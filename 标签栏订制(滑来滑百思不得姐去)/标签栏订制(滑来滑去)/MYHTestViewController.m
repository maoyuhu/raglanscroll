//
//  MYHTestViewController.m
//  标签栏订制(滑来滑去)
//
//  Created by myh on 16/5/27.
//  Copyright © 2016年 myh. All rights reserved.
//

#import "MYHTestViewController.h"
#import "XMGVerticalButton.h"
#import <POP.h>
/**
 *  delay 系数 时间
 */
static CGFloat const MYHAnimationDelay = 0.1;
/**
 *  factor 中立大小
 */

static CGFloat const MYHSpringFactor = 10;

@interface MYHTestViewController ()

@end

@implementation MYHTestViewController
- (IBAction)cancel {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.view.userInteractionEnabled = NO;
    NSArray *titArr = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    NSArray *imageArr = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    
    // 中间的6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (kHEIGHT - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (kWIDTH - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i<imageArr.count; i++) {
        XMGVerticalButton *button = [[XMGVerticalButton alloc] init];
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
           [self.view addSubview:button];
        // 设置frame
//        button.width = buttonW;
//        button.height = buttonH;
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat  buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat  buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - kHEIGHT;
//
        
        
        //按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springSpeed = MYHSpringFactor;
        anim.springBounciness = MYHSpringFactor;
        anim.beginTime = CACurrentMediaTime()+MYHAnimationDelay*i;//执行时间
        [button pop_addAnimation:anim forKey:nil];//添加动画
                                                                 
        
    }
    UIImageView *slogView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];

    slogView.centerY = -100;
    [self.view addSubview:slogView];
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.springBounciness = MYHAnimationDelay;
    anim.springSpeed = MYHAnimationDelay;
    CGFloat centrtX = kWIDTH*0.5;
    CGFloat centerEndY =  kHEIGHT*0.2;
    CGFloat centerBeginY = centerEndY - kHEIGHT;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centrtX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centrtX, centerEndY)];
    [slogView pop_addAnimation:anim forKey:nil];
    anim.beginTime = CACurrentMediaTime() +titArr.count*MYHAnimationDelay;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        self.view.userInteractionEnabled = YES;
    }];
}
- (void)onClicked{
    
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"qqweq");
    
}
/**
 *  当第一次使用这个类的时候会调用一次
 */
+ (void)initialize{

    NSLog(@"initialize");

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
