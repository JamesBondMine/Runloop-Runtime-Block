//
//  TabViewController.m
//  闭包代理
//
//  Created by hipiao on 2017/2/22.
//  Copyright © 2017年 James. All rights reserved.
//

#import "TabViewController.h"

typedef BOOL (^runloopBlock)(void);



static NSString * IDENTIFIER = @"IDENTIFIER";
static float cellHeight = 100.f;

@interface TabViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray * tasks;
@property (nonatomic,assign) NSInteger  maxQuneLength;
@property (nonatomic,strong) UITableView * customTable;
@property (nonatomic,strong) NSTimer * cuntomTimer;
@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.cuntomTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerMotherd) userInfo:nil repeats:YES];
    [self.customTable registerClass:[UITableViewCell class] forCellReuseIdentifier:IDENTIFIER];
    
    //添加runloop观察者
    [self addRunloopObsever];
    
    self.maxQuneLength = 18;
    self.tasks = [NSMutableArray array];
}
-(void)loadView{
    self.view = [UIView new];
    self.customTable = [UITableView new];
    self.customTable.delegate = self;
    self.customTable.dataSource = self;
    self.customTable.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3];
    [self.view addSubview:self.customTable];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.customTable.frame = [UIScreen mainScreen].bounds;
}
-(void)createUi{

}
-(void)timerMotherd{

}
+(void)addLabel:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath{

    UILabel * lbName = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, screenWith-10, 20)];
    lbName.backgroundColor = [UIColor redColor];
    lbName.text = [NSString stringWithFormat:@"%zd -- Drawing indexPath is  top  ",indexPath.row];
    [cell.contentView addSubview:lbName];
    
    UILabel * lbSex = [[UILabel alloc]initWithFrame:CGRectMake(5, 20, screenWith-10, 20)];
    lbSex.lineBreakMode = NSLineBreakByWordWrapping;
    lbSex.backgroundColor = [UIColor greenColor];
    lbSex.text = [NSString stringWithFormat:@"%zd -- Drawing indexPath is  top  Large image is low priority",indexPath.row];
    [cell.contentView addSubview:lbSex];
    
}
+(void)addImage1With:(UITableViewCell *)cell {

    UIImageView * imag = [[UIImageView alloc]initWithFrame:CGRectMake(0, 40, screenWith/3, 60)];
    imag.image = [UIImage imageNamed:@"timg.jpg"];;
    [UIView transitionWithView:cell.contentView duration:0.3 options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionTransitionCrossDissolve) animations:^{
        [cell.contentView addSubview:imag];
    } completion:nil];

}
+(void)addImage2With:(UITableViewCell *)cell {
    
    UIImageView * imag = [[UIImageView alloc]initWithFrame:CGRectMake(screenWith/3, 40, screenWith/3, 60)];
    [imag sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488183867&di=0c4e15a88992b5633c1a5774440685fe&imgtype=jpg&er=1&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fpic%2Fitem%2Fd043ad4bd11373f0698d590fa40f4bfbfaed04eb.jpg"] placeholderImage:[UIImage imageNamed:@"timg"]];
    [UIView transitionWithView:cell.contentView duration:0.3 options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionTransitionCrossDissolve) animations:^{
        [cell.contentView addSubview:imag];
    } completion:nil];
    
}
+(void)addImage3With:(UITableViewCell *)cell {
    
    UIImageView * imag = [[UIImageView alloc]initWithFrame:CGRectMake(screenWith/3*2, 40, screenWith/3, 60)];
    imag.image = [UIImage imageNamed:@"spaceship.jpg"];
    [UIView transitionWithView:cell.contentView duration:0.3 options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionTransitionCrossDissolve) animations:^{
        [cell.contentView addSubview:imag];
    } completion:nil];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return cellHeight;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 100;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (UIView * cview in cell.contentView.subviews) {
        [cview removeFromSuperview];
    }

    
    [TabViewController addLabel:cell indexPath:indexPath];
    
    [self addtasks:^BOOL{
        [TabViewController addImage1With:cell];
        return YES;
    }];
    
    [self addtasks:^BOOL{
        [TabViewController addImage2With:cell];
        return YES;
    }];
    [self addtasks:^BOOL{
        [TabViewController addImage3With:cell];
        return YES;
    }];
    
    return  cell;

}
#pragma mark - <关于runloop的方法>
//添加新任务的方法
-(void)addtasks:(runloopBlock)uit{

    [self.tasks addObject:uit];
    //保证数组不溢出
    if (self.tasks.count > self.maxQuneLength) {
        [self.tasks removeObjectAtIndex:0];
    }
}
static void Callback(CFRunLoopObserverRef observer,CFRunLoopActivity activity,void * info){

    //拿到的就是自己
    TabViewController * vc = (__bridge TabViewController *)info;

    if (vc.tasks.count == 0) {
        return;
    }

    
    BOOL result = NO;
    
    //取出第一个任务
    while (result == NO && vc.tasks.count) {
        runloopBlock unit = vc.tasks.firstObject;
        result = unit();
        [vc.tasks removeObjectAtIndex:0];
    }
}
//这里都是C语言函数
-(void)addRunloopObsever{

    //拿到当前runloop 子线程runloop默认只执行一次
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    //定义一个context
    CFRunLoopObserverContext contect = {
        0,
        (__bridge void *)(self),
        &CFRetain,
        CFRelease,
        NULL
    };
    //定义一个观察者
    CFRunLoopObserverRef defaultModelObserver;
    //创建观察者
    defaultModelObserver = CFRunLoopObserverCreate(NULL, kCFRunLoopAfterWaiting, YES, NSIntegerMax-99, &Callback, &contect);
    //添加当前runloop的观察者
    CFRunLoopAddObserver(runloop, defaultModelObserver, kCFRunLoopDefaultMode);
    
    //c语言里出现  create\new\copy
    CFRelease(defaultModelObserver);

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
