//
//  ViewController.m
//  链式编程思想
//
//  Created by myh on 16/5/26.
//  Copyright © 2016年 myh. All rights reserved.
//

/**
 * 链式编程思想: 把要做的事情封装到block,给外界提供一个返回这个block的方法
 *
 链式编程思想方法特点:方法返回值必须是block block参数:放需要操作的内容 block返回值 :方法调用者
 *  @param void <#void description#>
 *
 *  @return <#return value description#>
 */
#import "ViewController.h"

#import "Custom.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Custom *c  = [[Custom alloc]init];
    [c setup];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
