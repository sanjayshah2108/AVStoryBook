//
//  Story.m
//  AVStoryBook
//
//  Created by Sanjay Shah on 2017-10-20.
//  Copyright © 2017 Sanjay Shah. All rights reserved.
//

#import "Story.h"

@implementation Story

- (instancetype) initWithIndex: (int) index
{
    self = [super init];
    if (self) {
        
        _pageIndex = index;
        
        NSString *audioFileNameForURL = [ NSString stringWithFormat:@"MyAudioFileForPage%i.m4a",index ];
        
        NSArray *pathComponents = [NSArray arrayWithObjects:
                                   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                                   audioFileNameForURL,
                                   nil];
        
        self.audioFileURL = [NSURL fileURLWithPathComponents:pathComponents];
        
    }
    
    return self;
}

@end
