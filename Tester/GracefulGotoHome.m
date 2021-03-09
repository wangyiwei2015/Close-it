//
//  NSObject+GracefulGotoHome.h
//  Tester
//
//  Created by Wangyiwei on 2020/3/15.
//  Copyright © 2020 Wangyiwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MagicLauncher : NSObject
+ (void)gotoHome;
@end

@implementation MagicLauncher
+ (void)gotoHome {
    SEL selector = NSSelectorFromString(@"suspend");
    ((void (*)(id,SEL))[[UIApplication sharedApplication] methodForSelector:selector])([UIApplication sharedApplication],selector);
}
@end
