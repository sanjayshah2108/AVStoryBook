//
//  CaptureViewController.m
//  AVStoryBook
//
//  Created by Sanjay Shah on 2017-10-20.
//  Copyright © 2017 Sanjay Shah. All rights reserved.
//

#import "CaptureViewController.h"

@interface CaptureViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *storyImageView;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIButton *recordAudioButton;

@end



@implementation CaptureViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt: kAudioFormatMPEG4AAC] forKey: AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat: 44100.0] forKey: AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey: AVNumberOfChannelsKey];
    
    // Initiate and prepare the recorder
    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:self.currentStory.audioFileURL
                                            settings:recordSetting
                                               error:NULL];
    self.audioRecorder.delegate = self;
    self.audioRecorder.meteringEnabled = YES;
    [self.audioRecorder prepareToRecord];
    
}



//method for setting up and managaing the image picker
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //if we choose camera, save the image
    if(self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera){
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    
    //give our image view the picked image, and dismiss picker
    self.storyImageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)capturePhoto:(UIButton *)sender {
    
    //init a picker
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    //use photo library as our source
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    //present this picker
    [self presentViewController:picker animated:YES completion:nil];
}

    

- (IBAction)recordAudio:(id)sender {
    
    NSLog(@"Creating an audio recording");
    
    //we dont want to record while the player is playing
    if (self.audioPlayer.playing) {
        [self.audioPlayer stop];
    }
    
    //Button does 2 things, records, and stops recording
    if (!self.audioRecorder.recording) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        // Start recording
        [self.audioRecorder record];
        
        [self.recordAudioButton setTitle:@"Pause" forState:UIControlStateNormal];
        [self.recordAudioButton setBackgroundColor:[UIColor redColor]];
        
    } else {

        [self.audioRecorder stop];
        // [self.audioRecorder pause];
        
        [self.recordAudioButton setTitle:@"Record" forState:UIControlStateNormal];
        [self.recordAudioButton setBackgroundColor:[UIColor purpleColor]];
    }
}


- (IBAction)playAudio:(UITapGestureRecognizer *)sender {
    
    //the button plays and stops
    if([self.audioPlayer isPlaying]) {
        [self.audioPlayer stop];
         NSLog(@"Stopped playing Audio");
    }
    else {
        self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:self.audioRecorder.url error:nil];
        [self.audioPlayer play];
        NSLog(@"Playing Audio");
    }
}




//
//- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag{
//    [_recordAudioButton setTitle:@"Record" forState:UIControlStateNormal];
//    [_recordAudioButton setBackgroundColor:[UIColor purpleColor]];
//
//    //
//
//
//
//}




//- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Done"
//                                                                   message:@"That's it folks"
//                                                            preferredStyle:UIAlertControllerStyleAlert];
//
//    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
//                                              style:UIAlertActionStyleDefault
//                                            handler:nil]];
//
//    [self presentViewController:alert animated:true completion:nil];
//}






@end
