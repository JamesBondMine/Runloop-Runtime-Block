//
//  MessigeViewController.m
//  闭包代理
//
//  Created by James Bond on 2017/2/19.
//  Copyright © 2017年 James. All rights reserved.
//

#import "MessigeViewController.h"
#import "Person.h"
#import "LoopViewController.h"
#import <objc/message.h>

@interface MessigeViewController ()

@end

@implementation MessigeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setRuntimeExample];
    
    [self setMotherdWithRuntime];
    
    
    
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
-(void)pushOther{

    [self dismissViewControllerAnimated:YES completion:nil];

}
-(void)pushOther1{
    
    LoopViewController * loop = [[LoopViewController alloc]init];
    [self presentViewController:loop animated:YES completion:nil];
    
}
#pragma runtime  发送消息调用方法 以及  归档街归档 ------------------------
-(void)setRuntimeExample{

    Person * p1 = [[Person alloc]init];
    [p1 eatAction];
    
    Class personClass = [Person class];
    
    objc_msgSend(personClass, @selector(eatAction));
    
    objc_msgSend(p1, @selector(eatAction));
    
    objc_msgSend(p1, @selector(eatTwice:foodOne:),@"肯德基",@"德克士");
    
    objc_msgSend(self, @selector(sendMessige));
    
    
    
    p1.userage = @"eating";
    p1.username = @"15701594500";
    p1.userheight = @"18厘米";
    
    NSLog(@"____________________________________\n%@",NSHomeDirectory());
    
    NSString * temp = NSHomeDirectory();
    //在Documents/外部归档的  真机显示归档失败，故必须归档在内部
    NSString * filePath = [temp stringByAppendingPathComponent:@"Documents/person.info"];
    [NSKeyedArchiver archiveRootObject:p1 toFile:filePath];
    
    
    Person * userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"----------------------------------\n解归档这位先生的信息是：%@ %@ %@",userInfo.username,userInfo.userheight,userInfo.userage);


}
#pragma runtime  动态添加方法
-(void)setMotherdWithRuntime{

    NSURL * request = [NSURL URLWithString:@"http://www.baidu.com／中文名字"];
    NSURLRequest * re = [NSURLRequest requestWithURL:request];
    
    NSLog(@"当前请求____________%@",re);

}
-(void)sendMessige{

    NSLog(@"给当前类发送消息");
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
