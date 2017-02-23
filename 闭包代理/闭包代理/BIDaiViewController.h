//
//  BIDaiViewController.h
//  闭包代理
//
//  Created by hipiao on 2017/2/17.
//  Copyright © 2017年 James. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 闭包
 @param logBlock 测试
 */
typedef void (^MysecondBlock)(NSString * logBlock);
typedef void (^DicBlock)(NSDictionary * dic);


/**
 代理
 */
@protocol CustomDelegate <NSObject>
@optional
/**
 代理方法
 @param myname 设置道理方法获取name
 */
-(void)setCustomDelegateMotherd:(NSString *)myname;

@end


@interface BIDaiViewController : UIViewController


/**
 调用闭包的属性
 */
@property (nonatomic,copy) MysecondBlock logBlock;

/**
 调用代理的属性
 */
@property (nonatomic,weak) id<CustomDelegate>delegate;


@property (nonatomic,copy) DicBlock cdic;


-(void)logBlockAction:(MysecondBlock)block;

-(void)currentDicBlock:(DicBlock)dic;

@end
