//
//  TBMainViewController.h
//  TBox
//
//  Created by kevin chen on 13-10-24.
//  Copyright (c) 2013年 MMS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBMainViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>{

    IBOutlet UISegmentedControl *_mainSegment;
    NSArray *loanMonthArray;
//    IBOutlet UIPickerView *_pickView;
    
    //first segment
    IBOutlet UITextField *_DKMoneyLabel;
    IBOutlet UIButton *_DKYearButton;
    IBOutlet UIButton *_DKFeeLabel;
    IBOutlet UISegmentedControl *_DKMethod;
    IBOutlet UIButton *_DK_Done;
    
    //second segment
    
    //third segment
    
}

@end
