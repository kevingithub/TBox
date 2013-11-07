//
//  TBDetailInformationController.h
//  TBox
//
//  Created by kevin chen on 13-11-6.
//  Copyright (c) 2013年 MMS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBDetailInformationController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UILabel *loanAmountLabel;
    IBOutlet UILabel *loanMonthLabel;
    IBOutlet UILabel *modeOfRepaymentLabel;
    IBOutlet UILabel *loanRatesLabel;
    IBOutlet UILabel *loanAmountHunHeLabel;
    IBOutlet UILabel *loanRatesHunHeLabel;
    
    IBOutlet UITableView *loanDetailTableView;
    LoanType *type;
    
}
- (id)initWithNib:(NSString*)nibName type:(LoanType *)type;


@end
