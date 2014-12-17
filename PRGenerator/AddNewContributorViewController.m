//
//  AddNewContributorViewController.m
//  PRGenerator
//
//  Created by Jean-Louis Danielo on 17/12/2014.
//  Copyright (c) 2014 Jean-Louis Danielo. All rights reserved.
//

#import "AddNewContributorViewController.h"

@interface AddNewContributorViewController ()

@end

@implementation AddNewContributorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"PRGenerator"]]];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.title = @"Ajouter un participant";
    
    // Vars init
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    UITextField *contributorNameInput = [[UITextField alloc] initWithFrame:CGRectMake(15, 150, screenWidth - 30, 50)];
    contributorNameInput.delegate = self;
    contributorNameInput.tag = 1;
    contributorNameInput.textColor = [UIColor whiteColor];
    contributorNameInput.backgroundColor = [UIColor cyanColor];
    contributorNameInput.textAlignment = NSTextAlignmentCenter;
    contributorNameInput.placeholder = @"Mon prénom";
    contributorNameInput.font = [UIFont fontWithName:@"HelveticaNeue" size:28.0f];
    [self.view addSubview:contributorNameInput];
    
    UIButton *addContributor = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [addContributor addTarget:self
                       action:@selector(addContributor)
             forControlEvents:UIControlEventTouchUpInside];
    addContributor.frame = CGRectMake(0, 220, screenWidth, 45.0);
    [addContributor setTitle:@"Je veux faire partie du jeu" forState:UIControlStateNormal];
    [addContributor setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:addContributor];
}

- (void) addContributor {
    UITextField *contributorNameInput = (UITextField*)[self.view viewWithTag:1];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([(NSArray *)[prefs objectForKey:@"contributors"] containsObject:contributorNameInput.text] ) {
        direction = 1;
        shakes = 0;
        [self shake:contributorNameInput];
        return;
    }
    
    NSMutableArray *contributorsList = [[NSMutableArray alloc] initWithArray:[prefs objectForKey:@"contributors"]];
    [contributorsList addObject:[contributorNameInput.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];

    [prefs setObject:[contributorsList sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] forKey:@"contributors"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addNewContributor" object:nil userInfo:nil];
}

-(void)shake:(UIView *)theOneYouWannaShake
{
    [UIView animateWithDuration:0.04 animations:^
     {
         theOneYouWannaShake.transform = CGAffineTransformMakeTranslation(5*direction, 0);
     }
                     completion:^(BOOL finished)
     {
         if(shakes >= 5)
         {
             theOneYouWannaShake.transform = CGAffineTransformIdentity;
             return;
         }
         shakes++;
         direction = direction * -1;
         [self shake:theOneYouWannaShake];
     }];
}

    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
