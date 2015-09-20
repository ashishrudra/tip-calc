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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.title = @"Tip Calculator";
    }
    self.title = @"Tip Calculator";
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    // Do any additional setup after loading the view.
    self.tipPercentageArray = @[@0.05, @0.10, @0.15, @0.20, @0.25];
    
    while(self.tipPercentageSegmentControl.numberOfSegments > 0) {
        [self.tipPercentageSegmentControl removeSegmentAtIndex:0 animated:NO];
    }
    for (int i = 0; i < self.tipPercentageArray.count; i++) {
        NSNumber * numberInArray = self.tipPercentageArray[i];
        NSString * numberString = [NSString stringWithFormat:@"%.0f%%", numberInArray.doubleValue * 100];
        [self.tipPercentageSegmentControl insertSegmentWithTitle:numberString atIndex:i animated:NO];
    }
    [self.tipPercentageSegmentControl setSelectedSegmentIndex:0];
    self.billAmountTextField.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)calculateTipAndUpdateLabels {
    NSNumber * tipPercentageNumber = self.tipPercentageArray[[self.tipPercentageSegmentControl selectedSegmentIndex]];
    NSInteger headCount = self.headCountSlider.value;
    
    double billAmount = self.billAmountTextField.text.doubleValue;
    double tipPercentage = tipPercentageNumber.doubleValue;
    
    // calculate tip
    double tipAmount = billAmount * tipPercentage;
    double totalAmount = tipAmount + billAmount;
    double totalPerPerson = totalAmount/headCount;
    
    //update the labels in the view
    self.tipAmountTextLabel.text = [NSString stringWithFormat:@"$%.2f", tipAmount];
    self.totalAmountTextLabel.text = [NSString stringWithFormat:@"$%.2f", totalAmount];
    self.totalPerPersonTextLabel.text = [NSString stringWithFormat:@"$%.2f", totalPerPerson];
    NSLog(@"%f  %f", tipAmount, totalAmount);
}

- (IBAction)didTapCalcaulateButton:(UIButton *)sender {
    NSLog(@"did tap calculate button");
    [self calculateTipAndUpdateLabels];
}
- (IBAction)changedHeadCount:(UISlider *)sender {
    NSLog(@"value changed");
    NSInteger headCount = self.headCountSlider.value;
    self.headCountTextLabel.text = [NSString stringWithFormat:@"%lu", headCount];
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
