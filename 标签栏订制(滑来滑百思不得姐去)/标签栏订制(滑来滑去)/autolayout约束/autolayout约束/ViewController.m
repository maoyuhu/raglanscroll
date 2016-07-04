//
//  ViewController.m
//  autolayout约束
//
//  Created by myh on 16/5/25.
//  Copyright © 2016年 myh. All rights reserved.
//
#define kWEIGHT  ([UIScreen mainScreen].bounds.size.width)
#define kHEIGHT  ([UIScreen mainScreen].bounds.size.height)


#import "ViewController.h"
#import "TableViewCell.h"



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{


    UITableView *_tableView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  setupUI];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)setupUI{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWEIGHT, kHEIGHT)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
      _tableView.rowHeight = UITableViewAutomaticDimension;
      _tableView.estimatedRowHeight  =250;
    [_tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
 
  
    
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return kHEIGHT*0.25;
//    
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];

    
    cell.textLabel.numberOfLines = 0;
    if (0==indexPath.row) {
        cell.textLabel.text = @"wefddortgofmbhfgk;;lfg 交换机不好看就你来看美女快捷键就不好看看了没几年电视剧哈佛的快乐没法打了;薄弱高合金钢分类科目表发过来;不辜负";
        

    }else if (1==indexPath.row){
    
     cell.textLabel.text = @"wefddortgofmbhfgk;;lfg ";
    
    }else if (2==indexPath.row){
    
      cell.textLabel.text = @"wefddortgofmbhfgk;;lfg 交换机不好看就你来看美女快捷键就不好看看了没几年电视剧哈佛wefddortgofmbhfgk;;lfg 交换机不好看就你来看美女快捷键就不好看看了没几年电视剧哈佛的快乐没法打了;薄弱高合金钢分类科目表发过来;不辜负wefddortgofmbhfgk;;lfg 交换机不好看就你来看美女快捷键就不好看看了没几年电视剧哈佛的快乐没法打了;薄弱高合金钢分类科目表发过来;不辜负wefddortgofmbhfgk;;lfg 交换机不好看就你来看美女快捷键就不好看看了没几年电视剧哈佛的快乐没法打了;薄弱高合金钢分类科目表发过来;不辜负的快乐没法打了;薄弱高合金钢分类科目表发过来;不辜负";
    
    }
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
