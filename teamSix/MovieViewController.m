//
//  MovieViewController.m
//  teamSix
//
//  Created by Shiuh Yaw Phang on 07/06/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import "MovieViewController.h"
#import "Movie.h"
#import "Features.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MovieViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel11;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel12;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel13;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel14;

@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel21;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel22;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel23;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel24;

@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel31;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel32;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel33;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel34;

@property (strong, nonatomic) UIImage *placeholderImage;

@end

@implementation MovieViewController


+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)placeholderImage
{
    if (_placeholderImage == nil) {
        _placeholderImage = [MovieViewController imageWithColor:[UIColor blackColor]];
    }
    return _placeholderImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Movie *movie1 = self.movieArray[0];
    NSURL *url1 = [NSURL URLWithString:movie1.poster_path];
    [self.imageView1 sd_setImageWithURL:url1 placeholderImage:self.placeholderImage];
    self.titleLabel11.text = movie1.original_title;
    self.titleLabel12.text = movie1.overview;
    Features * feature1 = movie1.features;
    
    self.titleLabel13.text = [NSString stringWithFormat:@"anger: %@ ,disgust: %@ , fear: %@,  joy: %@, sadness: %@", feature1.anger, feature1.disgust, feature1.fear, feature1.joy, feature1.sadness];

    Movie *movie2 = self.movieArray[1];
    NSURL *url2 = [NSURL URLWithString:movie2.poster_path];
    [self.imageView2 sd_setImageWithURL:url2 placeholderImage:self.placeholderImage];
    self.titleLabel21.text = movie2.original_title;
    self.titleLabel22.text = movie2.overview;
    Features * feature2 = movie2.features;
    self.titleLabel23.text = [NSString stringWithFormat:@"anger: %@ ,disgust: %@ , fear: %@,  joy: %@, sadness: %@", feature2.anger, feature2.disgust, feature2.fear, feature2.joy, feature2.sadness];

    Movie *movie3 = self.movieArray[2];
    NSURL *url3 = [NSURL URLWithString:movie3.poster_path];
    [self.imageView3 sd_setImageWithURL:url3 placeholderImage:self.placeholderImage];
    self.titleLabel31.text = movie3.original_title;
    self.titleLabel32.text = movie3.overview;
    Features * feature3 = movie3.features;
    self.titleLabel33.text = [NSString stringWithFormat:@"anger: %@ ,disgust: %@ , fear: %@,  joy: %@, sadness: %@", feature3.anger, feature3.disgust, feature3.fear, feature3.joy, feature3.sadness];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissButtonDidTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
