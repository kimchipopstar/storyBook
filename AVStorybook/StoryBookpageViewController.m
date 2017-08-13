//
//  StoryBookpageViewController.m
//  AVStorybook
//
//  Created by Jaewon Kim on 2017-08-11.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

#import "StoryBookpageViewController.h"
#import "Model.h"
#import "SBViewController.h"

@interface StoryBookpageViewController () <UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (nonatomic, strong) NSArray *modelArray;

@end

@implementation StoryBookpageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataSource = self;
    self.delegate = self;
    Model *model1 = [Model new];
    Model *model2 = [Model new];
    Model *model3 = [Model new];
    Model *model4 = [Model new];
    Model *model5 = [Model new];
    
    self.modelArray = @[model1,model2,model3,model4,model5];
    
    SBViewController *sbVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SBVC"];
 
    sbVC.model = self.modelArray[sbVC.pageNumber];
    [self setViewControllers:@[sbVC] direction:(UIPageViewControllerNavigationDirectionForward) animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    int currentNumber = ((SBViewController *)viewController).pageNumber;
    
    SBViewController *nextPage = [self.storyboard instantiateViewControllerWithIdentifier:@"SBVC"];
    
    nextPage.pageNumber = currentNumber + 1;
    
//    Model *model = self.modelArray[currentNumber];
//    nextPage.imageview
    
    return  nextPage;
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    int currentNumber = ((SBViewController*)viewController).pageNumber;
    
    if (currentNumber ==0) {
        return nil;
    }
    
    SBViewController *previousPage = [self.storyboard instantiateViewControllerWithIdentifier:@"SBVC"];
    
    previousPage.pageNumber = currentNumber - 1;
    
    return previousPage;
}

@end
