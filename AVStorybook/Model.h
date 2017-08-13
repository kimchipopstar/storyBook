//
//  Model.h
//  AVStorybook
//
//  Created by Jaewon Kim on 2017-08-11.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface Model : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end
