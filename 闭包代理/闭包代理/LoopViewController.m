//
//  LoopViewController.m
//  闭包代理
//
//  Created by hipiao on 2017/2/20.
//  Copyright © 2017年 James. All rights reserved.
//

#import "LoopViewController.h"
#import "TabViewController.h"

@interface LoopViewController ()
<
  UITableViewDelegate,
  UITableViewDataSource
>
@property (nonatomic,strong) UITableView * customTable;
@end

@implementation LoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self createView];
    
}
-(void)createView{

    self.customTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.customTable.delegate = self;
    self.customTable.dataSource = self;
    [self.view addSubview:self.customTable];
    
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(10, 10, 60, 60);
    btn1.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn1];
    [btn1 addTarget:self action:@selector(pushOther1) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)pushOther1{

    
    [NSString stringWithFormat:@"缓存文件：%0.2fM",[[SDImageCache sharedImageCache]getSize]/1024.0/1024.0];
    
    
    [[SDImageCache sharedImageCache]clearMemory];
    [[SDImageCache sharedImageCache]clearDisk];
    
    [self.customTable reloadData];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 150;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1000;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * cellId = @"cell";
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    for (UIView * _view in cell.contentView.subviews) {
        [_view removeFromSuperview];
    }
    
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, screenWith/2-10, 60)];
    [image sd_setImageWithURL:[NSURL URLWithString:@"http://www.bizhiwa.com/uploads/allimg/2012-02/18155H3-1-291605.jpg"] placeholderImage:[UIImage imageNamed:@"tim g"]];
    [cell.contentView addSubview:image];
    image.layer.masksToBounds = YES;
    image.layer.cornerRadius  = 10;
    image.alpha = 0.75;
   


    UIImageView * image1 = [[UIImageView alloc]initWithFrame:CGRectMake(screenWith/2+10, 10, screenWith/2-20, 60)];
    [image1 sd_setImageWithURL:[NSURL URLWithString:@"http://a1.qpic.cn/psb?/bda1cfb6-4958-4d5a-8299-f8ccdb6ffb9d/aOPGMoFTd0HxjQJybmPcEGZGjYFOzDQ2lWQ6QbPgWfM!/b/dAgBAAAAAAAA&bo=IAMVAgAAAAAFABc!&rf=viewer_4"] placeholderImage:[UIImage imageNamed:@"ti mg"]];
    [cell.contentView addSubview:image1];
    image1.layer.masksToBounds = YES;
    image1.layer.cornerRadius  = 10;
    image1.alpha = 0.75;

    UIImageView * image2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 80, screenWith/2-10, 50)];
    [image2 sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488183867&di=0c4e15a88992b5633c1a5774440685fe&imgtype=jpg&er=1&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fpic%2Fitem%2Fd043ad4bd11373f0698d590fa40f4bfbfaed04eb.jpg"] placeholderImage:[UIImage imageNamed:@"t img"]];
    [cell.contentView addSubview:image2];
    image2.layer.masksToBounds = YES;
    image2.layer.cornerRadius  = 10;
    image2.alpha = 0.75;
    
    UIImageView * image3 = [[UIImageView alloc]initWithFrame:CGRectMake(screenWith/2+10, 80, screenWith/2-20, 50)];
    [image3 sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488183867&di=0c4e15a88992b5633c1a5774440685fe&imgtype=jpg&er=1&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fpic%2Fitem%2Fd043ad4bd11373f0698d590fa40f4bfbfaed04eb.jpg"] placeholderImage:[UIImage imageNamed:@"ti mg"]];
    [cell.contentView addSubview:image3];
    image3.layer.masksToBounds = YES;
    image3.layer.cornerRadius  = 10;

    image3.alpha = 0.75;
    
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    TabViewController * tab = [[TabViewController alloc]init];
    [self presentViewController:tab animated:YES completion:nil];
}
-(void)runloopAction:(id )currentObject{

    NSLog(@"%@",currentObject);
    
    //[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

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
