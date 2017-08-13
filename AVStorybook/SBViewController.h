//
//  SBViewController.h
//  AVStorybook
//
//  Created by Jaewon Kim on 2017-08-11.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface SBViewController : UIViewController

@property (assign) int pageNumber;
@property (nonatomic, strong) Model *model;

@end
