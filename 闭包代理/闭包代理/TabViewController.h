//
//  TabViewController.h
//  闭包代理
//
//  Created by hipiao on 2017/2/22.
//  Copyright © 2017年 James. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabViewController : UIViewController

+(void)addImage1With:(UITableViewCell *)cell;
+(void)addImage2With:(UITableViewCell *)cell;
+(void)addImage3With:(UITableViewCell *)cell;
+(void)addLabel:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;

@end
