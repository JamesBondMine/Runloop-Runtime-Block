//
//  BIDaiViewController.m
//  闭包代理
//
//  Created by hipiao on 2017/2/17.
//  Copyright © 2017年 James. All rights reserved.
//

#import "BIDaiViewController.h"
#import "MessigeViewController.h"
@interface BIDaiViewController ()

@end

@implementation BIDaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 100, self.view.frame.size.width, 60);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(pushOther) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 200, self.view.frame.size.width, 60);
    btn1.backgroundColor = [UIColor redColor];
    [btn1 setTitle:@"跳转" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    [btn1 addTarget:self action:@selector(pushOther1) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)pushOther1{
    
    [self.delegate setCustomDelegateMotherd:@"这就是代理的名字"];
    
    MessigeViewController * mesg = [[MessigeViewController alloc]init];
    [self presentViewController:mesg animated:YES completion:nil];
}
-(void)pushOther{
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"要返回了");
    }];
}
-(void)logBlockAction:(MysecondBlock)block{

    self.logBlock = block;
}
-(void)viewDidAppear:(BOOL)animated{

    self.logBlock(@"回去的时候打印这个");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillDisappear:(BOOL)animated{

    self.cdic(@{@"性别":@"女"});
}
-(void)currentDicBlock:(DicBlock)dic{

    
    self.cdic = dic;
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
