//
//  Story.h
//  AVStoryBook
//
//  Created by Sanjay Shah on 2017-10-20.
//  Copyright © 2017 Sanjay Shah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>



@interface Story : NSObject

@property UIImage *storyImage;
@property (strong, nonatomic) NSURL *audioFileURL;
@property (nonatomic) int pageIndex;

- (instancetype) initWithIndex: (int) index;

@end
