//
//  AddContributorViewController.m
//  PRGenerator
//
//  Created by Jean-Louis Danielo on 17/12/2014.
//  Copyright (c) 2014 Jean-Louis Danielo. All rights reserved.
//

#import "AddContributorViewController.h"

@interface AddContributorViewController ()

@end

@implementation AddContributorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // View init
#pragma mark - View init
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"PRGenerator"]]];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    // Vars init
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([prefs objectForKey:@"contributors"] == nil) {
        [prefs setObject:@[@"Pikachu", @"Bulbizarre", @"Carapuce", @"Salamèche"] forKey:@"contributors"];
    }
    
    contributorsList = [[NSMutableArray alloc] initWithArray:[prefs objectForKey:@"contributors"]];
    
    UITableView *contributorsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStylePlain];
    contributorsTableView.delegate = self;
    contributorsTableView.dataSource = self;
    contributorsTableView.backgroundColor = [UIColor clearColor];
    contributorsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    contributorsTableView.allowsMultipleSelectionDuringEditing = NO;
    [self.view addSubview:contributorsTableView];
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
    }
    cell.textLabel.text = [contributorsList objectAtIndex:indexPath.row];
 
    return cell;
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

@end
