//
//  TextMateDrop.m
//  ShinyDroplets
//
//  Created by Matteo Rattotti on 6/27/08.
//  Copyright 2008 www.shinyfrog.net. All rights reserved.
//

#import "TextMateDropController.h"


@implementation TextMateDropController

- (void)application:(NSApplication *)sender openFiles:(NSArray *)filePaths{
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/Applications/Textmate.app/Contents/Resources/mate"];
    [task setArguments:filePaths];
    [task launch];
    [task release];

    [sender replyToOpenOrPrint:NSApplicationDelegateReplySuccess];
    [sender performSelector:@selector(terminate:) withObject:self afterDelay:0.1];
}


- (NSString *) appName{
    return @"TextMate";
}
@end
