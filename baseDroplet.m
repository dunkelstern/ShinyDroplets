//
//  baseDroplet.m
//  ShinyDroplets
//
//  Created by Matteo Rattotti on 6/27/08.
//  Copyright 2008 www.shinyfrog.net. All rights reserved.
//

#import "baseDroplet.h"


@implementation baseDroplet
- (void) awakeFromNib{
    returnDescriptor = NULL;
    
    [self setDropScript];
    [self setActivateScript];
    //NSLog(scriptDrop);
}


- (void) executeScript: (NSString *) theScript{
    scriptObject = [[NSAppleScript alloc] initWithSource: theScript];
    returnDescriptor = [scriptObject executeAndReturnError: &errorDict];
    if (returnDescriptor == NULL)
    {
        // Handling errors
        NSLog(@"Errors occured!");
        NSLog(@"Errors: %@", errorDict);
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification{
    [self executeScript:scriptActivate];
    [NSApp terminate:self];
}

- (void)application:(NSApplication *)sender openFiles:(NSArray *)filePaths{
    int i, n;
    n = [filePaths count];
    for(i=0; i<n; i++){
        [self executeScript:[NSString stringWithFormat:scriptDrop,[self appName], [filePaths objectAtIndex:i]]];
    }
    [sender replyToOpenOrPrint:NSApplicationDelegateReplySuccess];
    [sender performSelector:@selector(terminate:) withObject:self afterDelay:0.1];
}

- (BOOL)application:(NSApplication *)sender openFile:(NSString *)filename {
    [self executeScript:[NSString stringWithFormat:scriptDrop,[self appName], filename]];
    [sender performSelector:@selector(terminate:) withObject:self afterDelay:0.1];
    return YES;
}

- (NSString *) appName{
    return @"";
}

- (void) setDropScript{
    scriptDrop = @"tell application \"%@\"\n activate \n open \"%@\"\n end tell";;
}

- (void) setActivateScript{
    NSBundle *thisBundle = [NSBundle mainBundle];
    scriptActivate = [[NSMutableString alloc]initWithContentsOfFile:[thisBundle pathForResource:@"scriptClick" ofType:@"scpt"] encoding:NSASCIIStringEncoding error:Nil];
    //scriptActivate = [[scriptActivate stringByReplacingOccurrencesOfString:@"APP" withString:[self appName]]retain];
    [scriptActivate replaceOccurrencesOfString:@"APP" withString:[self appName] options:nil range:NSMakeRange(0, [scriptActivate length])];
}

@end
