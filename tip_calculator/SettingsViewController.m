//
//  SettingsViewController.m
//  tip_calculator
//
//  Created by Ashish Kumar Rudra on 9/19/15.
//  Copyright (c) 2015 Ashish Kumar Rudra. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UIStepper *poorServiceStepper;
@property (weak, nonatomic) IBOutlet UIStepper *fairServiceStepper;
@property (weak, nonatomic) IBOutlet UIStepper *goodServiceStepper;
@property (weak, nonatomic) IBOutlet UIStepper *greatServiceStepper;
@property (weak, nonatomic) IBOutlet UIStepper *excellentServiceStepper;
@property (weak, nonatomic) IBOutlet UILabel *poorServiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *fairServiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodServiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *greatServiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *excellentServiceLabel;

- (void)setTipPercentagesWithPoorService:(NSInteger)poorServiceTip withFairService:(NSInteger)fairServiceTip withGoodService:(NSInteger)goodServiceTip
                        withGreatService: (NSInteger)greatServiceTip withExcellentService: (NSInteger)excellentServiceTip;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.title = @"Settings";
    }
    
    return self;
}

- (void)setTipPercentagesWithPoorService:(NSInteger)poorServiceTip withFairService:(NSInteger)fairServiceTip withGoodService:(NSInteger)goodServiceTip
                        withGreatService: (NSInteger)greatServiceTip withExcellentService: (NSInteger)excellentServiceTip {
    self.poorServiceLabel.text = [NSString stringWithFormat:@"%ld%%", poorServiceTip];
    self.fairServiceLabel.text = [NSString stringWithFormat:@"%ld%%", fairServiceTip];
    self.goodServiceLabel.text = [NSString stringWithFormat:@"%ld%%", goodServiceTip];
    self.greatServiceLabel.text = [NSString stringWithFormat:@"%ld%%", greatServiceTip];
    self.excellentServiceLabel.text = [NSString stringWithFormat:@"%ld%%", excellentServiceTip];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger poorServiceTip = [defaults integerForKey:@"poorServiceTip"];
    NSInteger fairServiceTip = [defaults integerForKey:@"fairServiceTip"];
    NSInteger goodServiceTip = [defaults integerForKey:@"goodServiceTip"];
    NSInteger greatServiceTip = [defaults integerForKey:@"greatServiceTip"];
    NSInteger excellentServiceTip = [defaults integerForKey:@"excellentServiceTip"];
    
    [self setTipPercentagesWithPoorService:poorServiceTip withFairService:fairServiceTip withGoodService:goodServiceTip withGreatService:greatServiceTip withExcellentService:excellentServiceTip];
    
    // Set the stepper values
    self.poorServiceStepper.value = poorServiceTip == 0 ? DEFAULT_POOR_SERVICE_TIP : poorServiceTip;
    self.fairServiceStepper.value = fairServiceTip == 0 ? DEFAULT_FAIR_SERVICE_TIP : fairServiceTip;
    self.goodServiceStepper.value = goodServiceTip == 0 ? DEFAULT_GOOD_SERVICE_TIP : goodServiceTip;
    self.greatServiceStepper.value = greatServiceTip == 0 ? DEFAULT_GREAT_SERVICE_TIP : greatServiceTip;
    self.excellentServiceStepper.value = excellentServiceTip == 0 ? DEFAULT_EXCELLENT_SERVICE_TIP : excellentServiceTip;
}

- (IBAction)steppersChanged {
    NSInteger poorServiceTip = self.poorServiceStepper.value;
    NSInteger fairServiceTip = self.fairServiceStepper.value;
    NSInteger goodServiceTip = self.goodServiceStepper.value;
    NSInteger greatServiceTip = self.greatServiceStepper.value;
    NSInteger excellentServiceTip = self.excellentServiceStepper.value;
    
    [self setTipPercentagesWithPoorService:poorServiceTip withFairService:fairServiceTip withGoodService:goodServiceTip withGreatService:greatServiceTip withExcellentService:excellentServiceTip];
    
    // Save to the NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:poorServiceTip forKey:@"poorServiceTip"];
    [defaults setInteger:fairServiceTip forKey:@"fairServiceTip"];
    [defaults setInteger:goodServiceTip forKey:@"goodServiceTip"];
    [defaults setInteger:greatServiceTip forKey:@"greatServiceTip"];
    [defaults setInteger:excellentServiceTip forKey:@"excellentServiceTip"];
    [defaults synchronize];
}

- (IBAction)greatStep:(UIStepper *)sender {
}
@end