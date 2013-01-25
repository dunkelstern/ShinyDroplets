//
//  SublimeDropController.m
//  ShinyDroplets
//
//  Created by Johannes Schriewer on 2013-01-25.
//  Copyright 2013 Johannes Schriewer. All rights reserved.
//

#import "SublimeDropController.h"

@implementation SublimeDropController

- (void)application:(NSApplication *)sender openFiles:(NSArray *)filePaths{
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"];
    NSMutableArray *arguments = [filePaths mutableCopy];
    [arguments insertObject:@"-n" atIndex:0];
    [task setArguments:arguments];
    [task launch];
    [task release];

    [sender replyToOpenOrPrint:NSApplicationDelegateReplySuccess];
    [sender performSelector:@selector(terminate:) withObject:self afterDelay:0.1];
}

- (NSString *) appName{
    return @"Sublime Text 2";
}

@end
