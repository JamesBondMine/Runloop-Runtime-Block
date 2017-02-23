//
//  Person.h
//  闭包代理
//
//  Created by James Bond on 2017/2/19.
//  Copyright © 2017年 James. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{

    NSString * name1;
}
@property (nonatomic,strong) NSString * username;
@property (nonatomic,strong) NSString * userage;
@property (nonatomic,strong) NSString * userheight;


+(void)eatAction;

-(void)eatAction;

-(void)eatTwice:(NSString *)food foodOne:(NSString *)foodOne;

@end
