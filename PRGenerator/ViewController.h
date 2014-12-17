//
//  ViewController.h
//  PRGenerator
//
//  Created by Jean-Louis Danielo on 14/12/2014.
//  Copyright (c) 2014 Jean-Louis Danielo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RQShineLabel.h"
#import "AddContributorViewController.h"


@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    CGFloat screenWidth;
    CGFloat screenHeight;
}


@property (nonatomic, retain) NSArray *contributorsList;
@property (nonatomic, retain) NSMutableArray *recipientsList;
@property (nonatomic, retain) UILabel *receiverText;

@property (nonatomic, retain) RQShineLabel *receiverShineLabel;

@end

