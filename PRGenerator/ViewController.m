//
//  ViewController.m
//  PRGenerator
//
//  Created by Jean-Louis Danielo on 14/12/2014.
//  Copyright (c) 2014 Jean-Louis Danielo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"PRGenerator"]]];
    
    // Vars init
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    
    UIImageView *appIcon = [[UIImageView alloc] initWithFrame:CGRectMake(133, 80, 58, 64)];
    appIcon.image = [UIImage imageNamed:@"PRGicon"];
    appIcon.opaque = YES;
    appIcon.backgroundColor = [UIColor clearColor];
    [self.view addSubview:appIcon];
    
//    UIButton *validChoice = [UIButton alloc] initWithFrame:<#(CGRect)#>
    
    UIButton *validChoiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [validChoiceButton addTarget:self action:@selector(getRandomUser) forControlEvents:UIControlEventTouchUpInside];
    validChoiceButton.frame = CGRectMake(140, 420, 60, 60);
    validChoiceButton.tag = 2;
    validChoiceButton.center = CGPointMake(self.view.center.x, 450);
//    validChoiceButton.contentEdgeInsets = UIEdgeInsetsMake(-10, -10, -10, -10);
    [validChoiceButton setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    validChoiceButton.backgroundColor = [UIColor clearColor];
    [self.view addSubview:validChoiceButton];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pushAddNewContributorsView)];

    
    self.contributorsList = [@[@"Pikachu", @"Bulbizarre", @"Carapuce", @"Salamèche"] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    self.recipientsList = [[NSMutableArray alloc] initWithArray:self.contributorsList];
    
    UILabel *topText = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, screenWidth, 40)];
    topText.text = @"Un cadeau de la part de ";
    topText.font = [UIFont fontWithName:@"Avenir" size:24];
    topText.textColor = [UIColor whiteColor];
    topText.backgroundColor = [UIColor clearColor];
    topText.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:topText];
    
    UIPickerView *contributorsListPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 150, screenWidth, 70)];
    contributorsListPickerView.dataSource = self;
    contributorsListPickerView.delegate = self;
    contributorsListPickerView.tag = 1;
    contributorsListPickerView.tintColor = [UIColor whiteColor];
    [self.view addSubview: contributorsListPickerView];
    
    UILabel *middleText = [[UILabel alloc] initWithFrame:CGRectMake(0, 280, screenWidth, 40)];
    middleText.text = @"pour";
    middleText.font = [UIFont fontWithName:@"Avenir" size:24];
    middleText.textColor = [UIColor whiteColor];
    middleText.backgroundColor = [UIColor clearColor];
    middleText.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:middleText];
    
    self.receiverText = [[UILabel alloc] initWithFrame:CGRectMake(0, 330, screenWidth, 40)];
//    self.receiverText.text = @"...";
//    self.receiverText.font = [UIFont fontWithName:@"Avenir" size:28];
//    self.receiverText.textColor = [UIColor whiteColor];
//    self.receiverText.backgroundColor = [UIColor clearColor];
//    self.receiverText.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:self.receiverText];
    
    self.receiverShineLabel = [[RQShineLabel alloc] initWithFrame:CGRectMake(0, 330, screenWidth, 40)];
    self.receiverShineLabel.text = @"...";
    self.receiverShineLabel.font = [UIFont fontWithName:@"Avenir" size:28];
    self.receiverShineLabel.textColor = [UIColor whiteColor];
    self.receiverShineLabel.backgroundColor = [UIColor clearColor];
    self.receiverShineLabel.textAlignment = NSTextAlignmentCenter;
    self.receiverShineLabel.fadeoutDuration = 2.42;
    
    [self.view addSubview:self.receiverShineLabel];
}

- (void) pushAddNewContributorsView
{
    ContributorsListViewController *addContributorViewController = [ContributorsListViewController new];
    
    [self.navigationController pushViewController:addContributorViewController animated:YES];
}

- (void) getRandomUser
{
    UIButton *validChoiceButton = (UIButton*)[self.view viewWithTag:2];
    
    // Current user can't receive present from him self
    if (self.recipientsList.count <= 0) {
        validChoiceButton.enabled = NO;
        UIAlertView *alertEndGame = [[UIAlertView alloc] initWithTitle:@"Merry Christmas" message:@"It's looks like we're done with this game. You can go home!" delegate:nil cancelButtonTitle:@"NOT NOW" otherButtonTitles: nil];
        [alertEndGame show];
        
        return;
    }
    
    UIPickerView *contributorsListPickerView = (UIPickerView*)[self.view viewWithTag:1];
    
    NSString *currentUser = [self.contributorsList objectAtIndex:[contributorsListPickerView selectedRowInComponent:0]];
    NSUInteger randomIndex = arc4random() % [self.recipientsList count];
    NSString *receiverName = [self.recipientsList objectAtIndex:randomIndex];
    

    if (![currentUser isEqualToString:receiverName]) {
        [self.recipientsList removeObject:receiverName];
        self.receiverShineLabel.text = receiverName;
        
        [self.receiverShineLabel shine];
        [self performSelector:@selector(fadingOut) withObject:self afterDelay:7.0];
    } else if(self.recipientsList.count == 1 && [currentUser isEqualToString:receiverName]) {
        
        UIAlertView *alertEndGame = [[UIAlertView alloc] initWithTitle:@"You fail dawg" message:@"It's looks like you're alone, now" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertEndGame show];
        
    } else {
        [self getRandomUser];
    }
    validChoiceButton.enabled = NO;
}

- (void) fadingOut
{
    [self.receiverShineLabel fadeOutWithCompletion:^{
        UIButton *validChoiceButton = (UIButton*)[self.view viewWithTag:2];
        validChoiceButton.enabled = YES;
    }];
}

// The number of columns of data
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.contributorsList.count;
}


// The data to return for the row and component (column) that's being passed in
//- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    return self.contributorsList[row];
//}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 35.0;
}


- (UIView *) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* tView = (UILabel*)view;
    if (!tView){
        tView = [UILabel new];
        tView.textColor = [UIColor whiteColor];
        tView.font = [UIFont fontWithName:@"Avenir" size:25.0f];
        tView.textAlignment = NSTextAlignmentCenter;
        
    }
    // Fill the label text here
    tView.text = self.contributorsList[row];
    return tView;
}


//- (void)pickerView:(UIPickerView *)pickerView
//      didSelectRow:(NSInteger)row
//       inComponent:(NSInteger)component {
//    NSLog(@"Install gentoo");
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
