//
//  MyPageViewController.m
//  AVStoryBook
//
//  Created by Sanjay Shah on 2017-10-21.
//  Copyright © 2017 Sanjay Shah. All rights reserved.
//

#import "MyPageViewController.h"
#import "Story.h"
#import "CaptureViewController.h"

@interface MyPageViewController ()

@property NSMutableArray *storyArray;
@property NSMutableArray *storyVCArray;
@property NSInteger currentStoryPage;


@end

@implementation MyPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = self;
    self.delegate = self;
    
    //statically iniiate 5 stories and add them to an array
    Story *storyOne = [[Story alloc] initWithIndex:1];
    Story *storyTwo = [[Story alloc] initWithIndex:2];
    Story *storyThree = [[Story alloc] initWithIndex:3];
    Story *storyFour = [[Story alloc] initWithIndex:4];
    Story *storyFive = [[Story alloc] initWithIndex:5];
    
    self.storyArray = [[NSMutableArray alloc] initWithObjects: storyOne, storyTwo, storyThree, storyFour, storyFive, nil];

    //make a VC array too
    self.storyVCArray = [[NSMutableArray alloc] init];
    
    self.currentStoryPage = 0;
    
    //make a CaptureViewController
    CaptureViewController *firstPageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"storyPartVC"];
    
    //get Story1 and give it to the firstPageCaptureController
    firstPageViewController.currentStory = self.storyArray[0];
    
    //add the VC to the VC array
    [self.storyVCArray addObject:firstPageViewController];
    
    [self setViewControllers:@[firstPageViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    //Page 1 initially
    self.navigationItem.title = [NSString stringWithFormat:@"Page 1"];
    
}



//for turning to the next page
- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerAfterViewController:(nonnull CaptureViewController *)viewController {
    
    //get our currentPage
    NSInteger currentIndex = [self.storyVCArray indexOfObject: viewController];
    NSLog(@"Current Page is: %ld", (long)currentIndex);
    
    //if theres already 5 VCs, alert them they cant add anymore
    if (currentIndex == (self.storyArray.count)-1){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:@"Youre on the last Page!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleDefault
                                                handler:nil]];
        
        [self presentViewController:alert animated:true completion:nil];
    }
    
    //only create a new VC if theres none
    else if (currentIndex + 1 >= self.storyVCArray.count) {
        CaptureViewController *nextPageCaptureViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"storyPartVC"];
        
        //make this next VCs story, teh next story from the StoryArray
        currentIndex++;
        nextPageCaptureViewController.currentStory = self.storyArray[currentIndex];

        //add this VC to the array
        [self.storyVCArray addObject:nextPageCaptureViewController];
    }
    
    else {
        currentIndex++;
    }
    
    self.navigationItem.title = [NSString stringWithFormat:@"Page %lu", currentIndex + 1];
    return self.storyVCArray[currentIndex];
}




//if we turn the page back
- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerBeforeViewController:(nonnull CaptureViewController *)viewController {
    
    NSInteger currentIndex = [self.storyVCArray indexOfObject: viewController];
    
    //if were on the first page, we dont want to turn back
    if (currentIndex == 0){
        //do nothing, just alert
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:@"Youre on the first Page!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleDefault
                                                handler:nil]];
        
        [self presentViewController:alert animated:true completion:nil];
    }
    
    //otherwise just reduce the index
    else {
        currentIndex--;
    }
    
    self.navigationItem.title = [NSString stringWithFormat:@"Page %lu", currentIndex + 1];
    return self.storyVCArray[currentIndex];
}


@end
