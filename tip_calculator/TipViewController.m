//
//  TipViewController.m
//  tip_calculator
//
//  Created by Ashish Kumar Rudra on 9/19/15.
//  Copyright (c) 2015 Ashish Kumar Rudra. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountTextLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipPercentageSegmentControl;
@property (weak, nonatomic) IBOutlet UILabel *headCountTextLabel;
@property (weak, nonatomic) IBOutlet UISlider *headCountSlider;
@property (weak, nonatomic) IBOutlet UILabel *totalPerPersonTextLabel;
@property (strong, nonatomic) NSArray *tipPercentageArray;

- (void)onSettingsButton;

@end

@implementation TipViewController


- (void)viewDidLoad {
    NSLog(@"view did load");
    [super viewDidLoad];
    
    self.title = @"Tip Calculator";
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    
    self.billAmountTextField.text = @"";
}

- (void)viewWillAppear:(BOOL)animated {
    [self calculateTipAndUpdateLabels];
}

- (void)updateTipPercentageSegmentLabels {
    NSInteger selectedIndex = [self.tipPercentageSegmentControl selectedSegmentIndex];
    NSInteger activeIndex = selectedIndex < 0 ? 0 : selectedIndex;
    while(self.tipPercentageSegmentControl.numberOfSegments > 0) {
        [self.tipPercentageSegmentControl removeSegmentAtIndex:0 animated:NO];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger poorServiceTip = [defaults integerForKey:@"poorServiceTip"];
    NSInteger fairServiceTip = [defaults integerForKey:@"fairServiceTip"];
    NSInteger goodServiceTip = [defaults integerForKey:@"goodServiceTip"];
    NSInteger greatServiceTip = [defaults integerForKey:@"greatServiceTip"];
    NSInteger excellentServiceTip = [defaults integerForKey:@"excellentServiceTip"];
    self.tipPercentageArray = @[@(poorServiceTip), @(fairServiceTip), @(goodServiceTip), @(greatServiceTip), @(excellentServiceTip)];
    
    // Set the segmented control button values
    for (int i = 0; i < self.tipPercentageArray.count; i++) {
        NSNumber * numberInArray = self.tipPercentageArray[i];
        NSString * numberString = [NSString stringWithFormat:@"%.0f%%", numberInArray.doubleValue];
        [self.tipPercentageSegmentControl insertSegmentWithTitle:numberString atIndex:i animated:NO];
    }
    [self.tipPercentageSegmentControl setSelectedSegmentIndex:activeIndex];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)calculateTipAndUpdateLabels {
    [self updateTipPercentageSegmentLabels];
    NSNumber * tipPercentageNumber = self.tipPercentageArray[[self.tipPercentageSegmentControl selectedSegmentIndex]];
    NSInteger headCount = self.headCountSlider.value;
    
    double billAmount = self.billAmountTextField.text.doubleValue;
    double tipPercentage = tipPercentageNumber.doubleValue;
    
    // calculate tip
    double tipAmount = billAmount * tipPercentage/100;
    double totalAmount = tipAmount + billAmount;
    double totalPerPerson = totalAmount/headCount;
    
    self.tipAmountTextLabel.text = [NSString stringWithFormat:@"$%.2f", tipAmount];
    self.totalAmountTextLabel.text = [NSString stringWithFormat:@"$%.2f", totalAmount];
    self.totalPerPersonTextLabel.text = [NSString stringWithFormat:@"$%.2f", totalPerPerson];
}
- (IBAction)billAmountChanged:(UITextField *)sender {
    [self calculateTipAndUpdateLabels];
}

- (IBAction)changedHeadCount:(UISlider *)sender {
    NSInteger headCount = self.headCountSlider.value;
    self.headCountTextLabel.text = [NSString stringWithFormat:@"%lu", headCount];
    [self calculateTipAndUpdateLabels];
}

- (IBAction)tipPercentageChanged:(UISegmentedControl *)sender {
    [self calculateTipAndUpdateLabels];
}

- (void)onSettingsButton {
    SettingsViewController *settingsViewController = [[SettingsViewController alloc] init];
    [self.navigationController pushViewController:settingsViewController animated:YES];
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
