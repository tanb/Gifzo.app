//
//  BorderlessWindow.m
//  Gifzo
//
//  Created by Kazato Sugimoto on 13/05/09.
//  Copyright (c) 2013年 Kazato Sugimoto. All rights reserved.
//

#import "BorderlessWindow.h"

@implementation BorderlessWindow

- (BOOL)canBecomeKeyWindow
{
    return YES;
}

- (BOOL)canBecomeMainWindow
{
    return YES;
}

@end
