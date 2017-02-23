//
//  ViewController.m
//  闭包代理
//
//  Created by hipiao on 2017/2/17.
//  Copyright © 2017年 James. All rights reserved.
//

#import "ViewController.h"
#import "BIDaiViewController.h"

@interface ViewController ()<CustomDelegate>

@end

@implementation ViewController

-(void)setCustomDelegateMotherd:(NSString *)myname{

    NSLog(@"跳转到了第三个页面，代理获取到了我的名字是：--- %@",myname);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 100, self.view.frame.size.width, 60);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(pushOther) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)pushOther{


    BIDaiViewController * bibao = [[BIDaiViewController alloc]init];
    bibao.delegate = self;
    [bibao logBlockAction:^(NSString * cText){
        NSLog(@"要打印的是：%@",cText);
    }];
    
    [bibao currentDicBlock:^(NSDictionary * cdic){
        NSLog(@"传回来的字典数据：%@",[cdic objectForKey:@"性别"]);
    }];
    [self presentViewController:bibao animated:YES completion:^{
        NSLog(@"跳转成功");
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
