//
//  ViewController.m
//  标签栏订制(滑来滑去)
//
//  Created by myh on 16/5/25.
//  Copyright © 2016年 myh. All rights reserved.
//

#define kWIDTH  [UIScreen mainScreen].bounds.size.width
#define kHEIGHT [UIScreen mainScreen].bounds.size.height



#import "ViewController.h"
#import "UIView+XMGExtension.h"

#import "MYHOneTableVC.h"
#import "MYHTwoTableVC.h"
#import "MYHThreeTableVC.h"
#import "MYHFourTableVC.h"
#import "MYHFiveTableVC.h"


@interface ViewController ()<UIScrollViewDelegate>

@property(nonatomic,weak)UIView *LineView;
@property(nonatomic,weak)UIButton *selectedBtn ;
@property(nonatomic,weak)UIView *markViews ;
@property(nonatomic,weak)UIScrollView *contentView ;
@end

@implementation ViewController
- (instancetype)init{

    self = [super init];
    if (self) {
        self.navigationItem.title = @"Viewcontroller";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.5];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil] ;
    // 初始化子控制器
    [self setupChildVces];
    [self setupButton];
    [self setupContentScView];
    
}

- (void)setupChildVces{

    MYHOneTableVC *one = [[MYHOneTableVC alloc]init];
    [self addChildViewController:one];
    
    MYHTwoTableVC *two = [[MYHTwoTableVC alloc]init];
    [self addChildViewController:two];
    
    MYHThreeTableVC *three = [[MYHThreeTableVC alloc]init];
    [self addChildViewController:three];
    
    MYHFourTableVC *four = [[MYHFourTableVC alloc]init];
    [self addChildViewController:four];
    
    MYHFiveTableVC *five = [[MYHFiveTableVC alloc]init];
    [self addChildViewController:five];
    

}
- (void)setupButton{
    
 
    UIView *markView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kWIDTH, 40)];
    markView.backgroundColor = [UIColor purpleColor];
    self.markViews = markView;
      [self.view addSubview:markView];
    
    //底部红色的指示器
    CGFloat marginH = 2;
    CGFloat marginY = markView.frame.size.height - marginH;
    UIView  *indicatorView = [[UIView alloc]initWithFrame:CGRectMake(0, marginY, 0, marginH)];
    indicatorView.backgroundColor = [UIColor redColor];
    self.LineView = indicatorView;
  
    
    int count = 5;
     CGFloat BtnWidth = kWIDTH/5;
     CGFloat BtnHeight = markView.frame.size.height;
    NSArray *titArr = @[@"好无",@"礼品",@"大鲨鱼",@"你好",@"他"];
    for (NSInteger i = 0; i < count; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake(i*BtnWidth, 0, BtnWidth, BtnHeight);
          button.tag = i;
        [button setTitle:titArr[i] forState:UIControlStateNormal];
        [button layoutIfNeeded];// 设置好字体 立刻强制布局
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        [button addTarget:self action:@selector(goClick:) forControlEvents:UIControlEventTouchDown];
        [markView addSubview:button];
        
        //设置第一个默认选中
        if (i==0) {
            button.enabled = NO;
            self.selectedBtn = button;
//            [button.titleLabel sizeToFit];//让按钮内部的label 根据内容来计算尺寸 第一次进来如果frame有偏差 就直接调整view的frame的x 方案一
            
//            CGRect Frame = self.LineView.frame;
//            Frame.size.width = button.titleLabel.frame.size.width;//方案一
//            Frame.size.width = [titArr[i]sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}].width;//方案2 似乎第一次还是有问题  还是要调整view的x
//            self.LineView.frame = Frame;

            
            
            //用分类的方法来写
            [button.titleLabel sizeToFit];
            self.LineView.width = button.titleLabel.width;
            self.LineView.centerX = button.centerX;
        }
    }
      [markView addSubview:self.LineView];
    }
- (void)setupContentScView{
    //穿透效果
    UIScrollView *ContentScView = [[UIScrollView alloc]init];
    ContentScView.frame = self.view.bounds;
    ContentScView.delegate = self;
    ContentScView.pagingEnabled = YES;
    ContentScView.backgroundColor = [UIColor greenColor];
    ContentScView.contentSize = CGSizeMake(ContentScView.width*self.childViewControllers.count, kHEIGHT);
    CGFloat top = CGRectGetMaxY(self.markViews.frame);
     ContentScView.contentInset = UIEdgeInsetsMake(top, 0, 0, 0);
    self.contentView = ContentScView;
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];

    [button setBackgroundColor:[UIColor yellowColor]];
    [button setTitle:@"Root视图" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    
    [ContentScView addSubview:button];
    
    
    [self.view insertSubview:ContentScView atIndex:0];

    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:ContentScView];

}
- (void)goClick:(UIButton *)btn{

    self.selectedBtn.enabled = YES;
   ;
    CGRect Frame = self.LineView.frame;
    Frame.size.width = btn.titleLabel.frame.size.width;
    self.LineView.frame = Frame;
    
    [UIView animateWithDuration:0.25 animations:^{
        
   
        CGPoint center = self.LineView.center;
        center.x = btn.center.x;//这里要注意 下次不要写btn.titleLabel.center.x 直接写 btn.center.x
         self.LineView.center = center ;

        
    }];
    btn.enabled = NO;
    self.selectedBtn = btn;
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = btn.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];

    
 }

#pragma mark scrollervice 的代理方法
//将要停止滑动
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger index = self.contentView.contentOffset.x/scrollView.width;
    //取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = self.contentView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    vc.tableView.pagingEnabled = YES;
    vc.tableView.contentInset = UIEdgeInsetsMake(104, 0, 0, 0);
    // 设置滚动条的内边距
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;

    
    [scrollView addSubview:vc.view];

    
}
//Decelerating 减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self goClick:self.markViews.subviews[index]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
