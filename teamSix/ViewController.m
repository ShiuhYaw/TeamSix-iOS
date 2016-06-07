//
//  ViewController.m
//  teamSix
//
//  Created by Shiuh Yaw Phang on 06/06/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import "ViewController.h"
#import "NetworkManager.h"
#import "MovieViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface ViewController ()

@property (nonatomic, strong) NSString *currentString;
@property (nonatomic, strong) MovieViewController *movieViewController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentString = @"I love you";
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getButtonDidTapped:(id)sender {
    UIButton *button = sender;
    NSString *string = button.titleLabel.text;
    __weak ViewController *weakSelf = self;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.square = YES;
    hud.color = [UIColor clearColor];
    hud.dimBackground = YES;

    
    [[NetworkManager sharedInstance] setupMovieCompletionBlock:^(NSArray *resultsArray, NSError *error) {
        NSLog(@"error %@", error);
        NSLog(@"resultsArray %@", resultsArray);
        if (error == nil) {
            if (resultsArray) {
                if (resultsArray.count > 0) {
                    
                    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                    weakSelf.movieViewController = [story instantiateViewControllerWithIdentifier:@"MovieViewController"];
                    weakSelf.movieViewController.movieArray = resultsArray;
                    [weakSelf presentViewController:weakSelf.movieViewController animated:YES completion:nil];
                }
            }
        }
    } withString:string];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
@end
