//
//  AddContributorViewController.h
//  PRGenerator
//
//  Created by Jean-Louis Danielo on 17/12/2014.
//  Copyright (c) 2014 Jean-Louis Danielo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AddNewContributorViewController.h"

@interface ContributorsListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    CGFloat screenWidth;
    CGFloat screenHeight;
    
    NSMutableArray *contributorsList;
}

@end
