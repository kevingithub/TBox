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
    LoanType loanType;
    float interest;
    float benXiPayOfMonth;
    float allPaymoney;
    //本金还款
    NSNumber *firstMonthPayMoney;
    NSNumber *secondMonthPayMoney;
    NSNumber *theN1MonthPayMoney;
    NSNumber *theLastMonthPayMoney;
    NSInteger count;
    
    
}
- (id)initWithNib:(NSString*)nibName type:(LoanType )type;


@end
