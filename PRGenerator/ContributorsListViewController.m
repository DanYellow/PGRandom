//
//  AddContributorViewController.m
//  PRGenerator
//
//  Created by Jean-Louis Danielo on 17/12/2014.
//  Copyright (c) 2014 Jean-Louis Danielo. All rights reserved.
//

#import "ContributorsListViewController.h"

@interface ContributorsListViewController ()

@end

@implementation ContributorsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // View init
#pragma mark - View init
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"PRGenerator"]]];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pushAddNewContributorsView)];
    
    // Vars init
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([prefs objectForKey:@"contributors"] == nil) {
        [prefs setObject:[@[@"Pikachu", @"Bulbizarre", @"Carapuce", @"Salamèche"] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] forKey:@"contributors"];
    }
    
    contributorsList = [[NSMutableArray alloc] initWithArray:[prefs objectForKey:@"contributors"]];
    
    
    
    UITableView *contributorsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 50) style:UITableViewStylePlain];
    contributorsTableView.delegate = self;
    contributorsTableView.dataSource = self;
    contributorsTableView.tag = 1;
    contributorsTableView.backgroundColor = [UIColor clearColor];
    contributorsTableView.tableFooterView = [UIView new];
    contributorsTableView.allowsMultipleSelectionDuringEditing = NO;
    contributorsTableView.allowsSelection = NO;
    [self.view addSubview:contributorsTableView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(contributorsListHaveBeenUpdateNotificationEvent) name: @"addNewContributor" object: nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return contributorsList.count;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor colorWithWhite:1 alpha:.15];
        cell.textLabel.textColor = [UIColor whiteColor];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [contributorsList objectAtIndex:indexPath.row];
 
    return cell;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animate {
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [contributorsList removeObjectAtIndex:indexPath.row];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:contributorsList forKey:@"contributors"];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)pushAddNewContributorsView {
    //    UITableView *contributorsTableView = (UITableView*)[self.view viewWithTag:1];
    AddNewContributorViewController *addNewContributorViewController = [AddNewContributorViewController new];
    addNewContributorViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissModal)];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addNewContributorViewController];
    [navigationController.navigationBar setBackgroundImage:[UIImage new]
                                          forBarMetrics:UIBarMetricsDefault];
    navigationController.navigationBar.shadowImage = [UIImage new];
    navigationController.navigationBar.translucent = YES;
    navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
    //    [contributorsTableView setEditing:YES animated:YES];
}

- (void) dismissModal
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void) contributorsListHaveBeenUpdateNotificationEvent
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    contributorsList = [[NSMutableArray alloc] initWithArray:[prefs objectForKey:@"contributors"]];
    
    UITableView *contributorsTableView = (UITableView*)[self.view viewWithTag:1];
    [contributorsTableView reloadData];
}

@end
