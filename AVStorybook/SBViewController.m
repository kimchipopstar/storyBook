//
//  SBViewController.m
//  AVStorybook
//
//  Created by Jaewon Kim on 2017-08-11.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

#import "SBViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface SBViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVAudioRecorderDelegate,AVAudioPlayerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;
@property (strong, nonatomic) AVAudioRecorder *audioRecorder;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end

@implementation SBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imagePicker = [[UIImagePickerController alloc]init];
//    
//    self.tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(screenTap:)];
//    [self.imageView addGestureRecognizer:self.tapGesture];

    
    self.playButton.enabled = NO;
    self.stopButton.enabled = NO;
    
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    NSString *soundFilePath = [docsDir stringByAppendingString:@"sound.caf"];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    NSDictionary *recordSeetings = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityMedium],AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:16],AVEncoderBitRateKey,
                                    [NSNumber numberWithInt:2],AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0],AVSampleRateKey, nil];
    
    NSError *error = nil;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    self.audioRecorder = [[AVAudioRecorder alloc]initWithURL:soundFileURL settings:recordSeetings error:&error];
    
    if (error){
        NSLog(@"error: %@",[error localizedDescription]);
    } else {
        [self.audioRecorder prepareToRecord];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



#pragma mark - record and play action method

- (IBAction)recordingButton:(UIButton *)sender {
    
    if (!self.audioRecorder.recording) {
        
        self.playButton.enabled = NO;
        self.stopButton.enabled = YES;
        [self.audioRecorder record];
    }
    
}
- (IBAction)stopButton:(id)sender {
    
    self.stopButton.enabled = NO;
    self.playButton.enabled = YES;
    self.recordButton.enabled = YES;
    
    if (self.audioRecorder.recording) {
        [self.audioRecorder stop];
    } else if (self.audioPlayer.playing) {
        [self.audioPlayer stop];
    }
    
}
- (IBAction)playButton:(UIButton *)sender {
    
    if (!self.audioRecorder.recording) {
        
        self.tapGesture.enabled = YES;
        self.recordButton.enabled = NO;
        NSError *error;
        
        self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:self.audioRecorder.url error:&error];
        
        _audioPlayer.delegate = self;
        
        if (error){
            NSLog(@"Error: %@",[error localizedDescription]);
        } else {
            [self.audioPlayer play];
        }
    }

    
}

//-(void)screenTap:(UITapGestureRecognizer*)sender{
//    if (!self.audioRecorder.recording) {
//        
//        self.tapGesture.enabled = YES;
//        self.recordButton.enabled = NO;
//        NSError *error;
//        
//        self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:self.audioRecorder.url error:&error];
//        
//        _audioPlayer.delegate = self;
//        
//        if (error){
//            NSLog(@"Error: %@",[error localizedDescription]);
//        } else {
//            [self.audioPlayer play];
//        }
//    }
//
//}

#pragma makr - record and play delegate method

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    self.recordButton.enabled = YES;
    self.stopButton.enabled = NO;
}

#pragma mark - photo and camera

- (IBAction)cameraButton:(UIButton *)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else {
        NSLog(@"aww");
    }
    [self presentViewController:self.imagePicker animated:YES completion:nil];
    
    self.imagePicker.delegate = self;
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.imageView.image = selectedImage;
}


@end
