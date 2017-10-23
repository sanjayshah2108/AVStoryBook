//
//  CaptureViewController.h
//  AVStoryBook
//
//  Created by Sanjay Shah on 2017-10-20.
//  Copyright © 2017 Sanjay Shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Story.h"

@interface CaptureViewController : UIViewController<AVAudioPlayerDelegate, AVAudioRecorderDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, strong) UIImagePickerController *imagePicker;

@property Story *currentStory;
@property NSInteger pageIndex;

@end
