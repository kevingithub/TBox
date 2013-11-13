//
//  TBMainViewController.h
//  TBox
//
//  Created by kevin chen on 13-10-24.
//  Copyright (c) 2013年 MMS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBMainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

    IBOutlet UISegmentedControl *_mainSegment;
    NSArray *loanMonthArray;
    NSArray *ratesArray;
    IBOutlet UITableView *_tableView;

//    IBOutlet UIPickerView *_pickView;
    
    //first segment
    IBOutlet UITextField *_DKMoneyLabel;
    IBOutlet UIButton *_DKYearButton;
    IBOutlet UIButton *_DKFeeLabel;
    IBOutlet UISegmentedControl *_DKMethod;
    IBOutlet UIButton *_DK_Done;
    IBOutlet UIView *_firstView;
    
    LoanType type ;

    
    //second segment
    
    //third segment
    
}
- (IBAction)getResultButton:(id)sender;
+ (double)getGJJCurrentRates:(NSInteger)month;
+ (double)getShangYeCurrentRates:(NSInteger)month style:(NSInteger)style;


@end
