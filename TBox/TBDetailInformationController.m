//
//  TBDetailInformationController.m
//  TBox
//
//  Created by kevin chen on 13-11-6.
//  Copyright (c) 2013年 MMS. All rights reserved.
//

#import "TBDetailInformationController.h"
#import "TBMainViewController.h"

@interface TBDetailInformationController ()


@end

@implementation TBDetailInformationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithNib:(NSString*)nibName type:(LoanType )type{
    self =[super initWithNibName:nibName bundle:Nil];
    if (self) {
        loanType = type;
        
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    if (loanType == LoanTypeHunhe_BenJin || loanType == LoanTypeHunhe_BenXi) {
        loanAmountHunHeLabel.hidden = NO;
        loanRatesHunHeLabel.hidden = NO;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    NSUserDefaults *loanParameter = [NSUserDefaults standardUserDefaults];
    NSNumber *monthValue = (NSNumber*)[loanParameter objectForKey:@"month"];
    NSNumber *ratesValue = (NSNumber*)[loanParameter objectForKey:@"rates"];
    NSNumber *moneyShangYe = (NSNumber *)[loanParameter objectForKey:@"loanShangYe"];
    NSNumber *moneyGongJiJin = (NSNumber *)[loanParameter objectForKey:@"loanGongJiJin"];
    
    NSInteger monthInt = [monthValue integerValue];
    NSInteger ratesInt = [ratesValue integerValue];
    NSInteger moneyIntGongJiJin = [moneyGongJiJin integerValue];
    NSInteger moneyIntShangYe = [moneyShangYe integerValue];
    
    
    
    loanMonthLabel.text = [monthValue stringValue];
    loanRatesLabel.text = [ratesValue stringValue];
 
    double rate ,rate_hunhe;
    
    switch (loanType) {
        case LoanTypeShangYE_BenJin:{
            modeOfRepaymentLabel.text = @"等额本金";
            rate = [TBMainViewController getShangYeCurrentRates:monthInt
                                                          style:ratesInt];
            loanRatesLabel.text = [NSString stringWithFormat:@"%.2f%@",rate*100,@"%"];
            loanAmountLabel.text = [NSString stringWithFormat:@"%d",moneyIntShangYe];
            NSArray *array = (NSArray *)[loanParameter objectForKey:@"sy_bj_paymoney"];
            count = [array count];
            firstMonthPayMoney = (NSNumber*)[array objectAtIndex:0];
            secondMonthPayMoney = (NSNumber*)[array objectAtIndex:1];
            theN1MonthPayMoney = (NSNumber*)[array objectAtIndex:count -2];
            theLastMonthPayMoney = (NSNumber*)[array objectAtIndex:count -1];
            allPaymoney = [loanParameter doubleForKey:@"benjin_allPayMoney"]/10000;
            interest = allPaymoney - moneyIntShangYe;
        }
            break;
        case LoanTypeShangYE_BenXi:{
            modeOfRepaymentLabel.text = @"等额本息";
            rate = [TBMainViewController getShangYeCurrentRates:monthInt
                                                          style:ratesInt];
            loanRatesLabel.text = [NSString stringWithFormat:@"%.2f%@",rate*100,@"%"];
            loanAmountLabel.text = [NSString stringWithFormat:@"%d",moneyIntShangYe];
            NSNumber *payMoneyBenXi =(NSNumber *)[loanParameter objectForKey:@"sy_bx_paymoney"];
            benXiPayOfMonth = [payMoneyBenXi doubleValue];
            allPaymoney = benXiPayOfMonth *monthInt/10000;
            interest = (allPaymoney - moneyIntShangYe);
            
            
        }
            break;
        case LoanTypeGongJiJin_BenJin:{
            modeOfRepaymentLabel.text = @"等额本金";
            rate = [TBMainViewController getGJJCurrentRates:
                           [monthValue integerValue]];
            loanRatesLabel.text = [NSString stringWithFormat:@"%.2f%@",rate*100,@"%"];
            loanAmountLabel.text = [NSString stringWithFormat:@"%d",moneyIntGongJiJin];
            NSArray *array = (NSArray *)[loanParameter objectForKey:@"gjj_bj_paymoney"];
            count = [array count];
            firstMonthPayMoney = (NSNumber*)[array objectAtIndex:0];
            secondMonthPayMoney = (NSNumber*)[array objectAtIndex:1];
            theN1MonthPayMoney = (NSNumber*)[array objectAtIndex:count -2];
            theLastMonthPayMoney = (NSNumber*)[array objectAtIndex:count -1];
            allPaymoney = [loanParameter doubleForKey:@"benjin_allPayMoney"]/10000;
            interest = allPaymoney - moneyIntShangYe;
        }
            break;
        case LoanTypeGongJiJin_BenXi:{
            modeOfRepaymentLabel.text = @"等额本息";
            rate = [TBMainViewController getGJJCurrentRates:
                           [monthValue integerValue]];
            loanRatesLabel.text = [NSString stringWithFormat:@"%.2f%@",rate*100,@"%"];
            loanAmountLabel.text = [NSString stringWithFormat:@"%d",moneyIntGongJiJin];
            NSNumber *paymoneyGongJiJinBenXi =(NSNumber *)[loanParameter objectForKey:@"gjj_bx_paymoney"];
            benXiPayOfMonth = [paymoneyGongJiJinBenXi doubleValue];
            allPaymoney = benXiPayOfMonth *monthInt/10000;
            interest = (allPaymoney - moneyIntShangYe);

        }
            break;
        case LoanTypeHunhe_BenJin:{
            modeOfRepaymentLabel.text = @"等额本金";
            rate = [TBMainViewController getGJJCurrentRates:
                    [monthValue integerValue]];
            
            loanAmountLabel.text = [NSString stringWithFormat:@"%d",moneyIntGongJiJin ];
            rate_hunhe =[TBMainViewController getShangYeCurrentRates:monthInt
                                                               style:ratesInt];
            loanAmountLabel.text = [NSString stringWithFormat:@"%d",moneyIntGongJiJin ];
            loanAmountHunHeLabel.text = [NSString stringWithFormat:@"商业贷款：%d",moneyIntShangYe];
            loanRatesLabel.text = [NSString stringWithFormat:@"%.2f%@",rate*100,@"%"];
            loanRatesHunHeLabel.text = [NSString stringWithFormat:@"商业贷款利率：%.2f%@",rate_hunhe*100,@"%"];
            
            NSArray *array = (NSArray *)[loanParameter objectForKey:@"hh_bj_paymoney"];
            count = [array count];
            firstMonthPayMoney = (NSNumber*)[array objectAtIndex:0];
            secondMonthPayMoney = (NSNumber*)[array objectAtIndex:1];
            theN1MonthPayMoney = (NSNumber*)[array objectAtIndex:count -2];
            theLastMonthPayMoney = (NSNumber*)[array objectAtIndex:count -1];
            allPaymoney = [loanParameter doubleForKey:@"hunhe_benjin"]/10000;
            interest = allPaymoney - moneyIntShangYe - moneyIntGongJiJin;
        
        }
            break;
        case LoanTypeHunhe_BenXi:{
            modeOfRepaymentLabel.text = @"等额本息";
            rate = [TBMainViewController getGJJCurrentRates:
                    [monthValue integerValue]];
            rate_hunhe =[TBMainViewController getShangYeCurrentRates:monthInt
                                                               style:ratesInt];
            loanAmountLabel.text = [NSString stringWithFormat:@"%d",moneyIntGongJiJin ];
            loanAmountHunHeLabel.text = [NSString stringWithFormat:@"商业贷款：%d",moneyIntShangYe];
            loanRatesLabel.text = [NSString stringWithFormat:@"%.2f%@",rate*100,@"%"];
            loanRatesHunHeLabel.text = [NSString stringWithFormat:@"商业贷款利率：%.2f%@",rate_hunhe*100,@"%"];
            
            
            NSNumber *paymoneyHunheBenXi =(NSNumber *)[loanParameter objectForKey:@"hh_paymoney"];
            benXiPayOfMonth = [paymoneyHunheBenXi doubleValue];
            allPaymoney = benXiPayOfMonth *monthInt/10000;
            interest = allPaymoney - moneyIntShangYe - moneyIntGongJiJin;
            
        }
            break;
            
        default:
            break;
    }
    
    [loanDetailTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    if (row == 2 && (loanType == LoanTypeGongJiJin_BenJin || loanType == LoanTypeShangYE_BenJin || loanType == LoanTypeHunhe_BenJin)) {
        return 112.0;
    }
    return 47.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSInteger row = [indexPath row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (!cell && (loanType ==LoanTypeGongJiJin_BenXi || loanType == LoanTypeShangYE_BenXi || loanType== LoanTypeHunhe_BenXi)) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
    UILabel *firstLabel,*secondLabel,*n1Label,*lastLabel;
    UILabel *n1MonthLabel,*lastMonthLabel;
    
    if (row == 2 &&!cell && (loanType == LoanTypeGongJiJin_BenJin || loanType == LoanTypeShangYE_BenJin || loanType == LoanTypeHunhe_BenJin)) {
        NSArray * nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"TBDetailBenJinTableViewCell" owner:self options:nil];
        cell = [nibTableCells objectAtIndex:0];
        firstLabel = (UILabel*)[cell viewWithTag:11];
        secondLabel = (UILabel*)[cell viewWithTag:12];
        n1Label = (UILabel*)[cell viewWithTag:13];
        lastLabel = (UILabel*)[cell viewWithTag:14];
        
        n1MonthLabel = (UILabel*)[cell viewWithTag:21];
        lastMonthLabel  = (UILabel*)[cell viewWithTag:22];
        
    }else{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    }
    
    
    // Configure the cell...
    
    
    switch (loanType) {
        case LoanTypeGongJiJin_BenXi:
            switch (row) {
                case 0:
                    cell.textLabel.text = [NSString stringWithFormat:@"%@:%.2f %@",@"还款总额",allPaymoney,@"万元"];
                    break;
                case 1:
                    cell.textLabel.text = [NSString stringWithFormat:@"%@:%.2f %@",@"利息总额",interest,@"万元"];
                    break;
                case 2:
                    cell.textLabel.text = [NSString stringWithFormat:@"%@:%.2f %@",@"每月还款",benXiPayOfMonth,@"元"];
                    break;
                    
            }
            break;
        case LoanTypeGongJiJin_BenJin:
            switch (row) {
                case 0:
                    cell.textLabel.text = [NSString stringWithFormat:@"%@:%.2f %@",@"还款总额",allPaymoney,@"万元"];
                    break;
                case 1:
                    cell.textLabel.text = [NSString stringWithFormat:@"%@:%.2f %@",@"利息总额",interest,@"万元"];
                    break;
                case 2:
                    firstLabel.text = [NSString stringWithFormat:@"%.2f",[firstMonthPayMoney doubleValue]];
                    secondLabel.text = [NSString stringWithFormat:@"%.2f",[secondMonthPayMoney doubleValue]];
                    n1Label.text = [NSString stringWithFormat:@"%.2f",[theN1MonthPayMoney doubleValue]];
                    lastLabel.text = [NSString stringWithFormat:@"%.2f",[theLastMonthPayMoney doubleValue]];
                    
                    n1MonthLabel.text = [NSString stringWithFormat:@"%@%d%@",@"第",count-1,@"月"];
                    lastMonthLabel.text = [NSString stringWithFormat:@"%@%d%@",@"第",count,@"月"];
                    break;
                    
            }
            break;
            
        case LoanTypeHunhe_BenJin:
            switch (row) {
                case 0:
                    cell.textLabel.text = [NSString stringWithFormat:@"%@:%.2f %@",@"还款总额",allPaymoney,@"万元"];
                    break;
                case 1:
                    cell.textLabel.text = [NSString stringWithFormat:@"%@:%.2f %@",@"利息总额",interest,@"万元"];
                    break;
                case 2:
                    firstLabel.text = [NSString stringWithFormat:@"%.2f",[firstMonthPayMoney doubleValue]];
                    secondLabel.text = [NSString stringWithFormat:@"%.2f",[secondMonthPayMoney doubleValue]];
                    n1Label.text = [NSString stringWithFormat:@"%.2f",[theN1MonthPayMoney doubleValue]];
                    lastLabel.text = [NSString stringWithFormat:@"%.2f",[theLastMonthPayMoney doubleValue]];
                    
                    n1MonthLabel.text = [NSString stringWithFormat:@"%@%d%@",@"第",count-1,@"月"];
                    lastMonthLabel.text = [NSString stringWithFormat:@"%@%d%@",@"第",count,@"月"];
                    break;
                    
            }
            break;
        case LoanTypeHunhe_BenXi:
            switch (row) {
                case 0:
                    cell.textLabel.text = [NSString stringWithFormat:@"%@:%.2f %@",@"还款总额",allPaymoney,@"万元"];
                    break;
                case 1:
                    cell.textLabel.text = [NSString stringWithFormat:@"%@:%.2f %@",@"利息总额",interest,@"万元"];
                    break;
                case 2:
                    cell.textLabel.text = [NSString stringWithFormat:@"%@:%.2f %@",@"每月还款",benXiPayOfMonth,@"元"];
                    break;
                    
            }

            break;
        case LoanTypeShangYE_BenXi:
            switch (row) {
                case 0:
                    cell.textLabel.text = [NSString stringWithFormat:@"%@:%.2f %@",@"还款总额",allPaymoney,@"万元"];
                    break;
                case 1:
                    cell.textLabel.text = [NSString stringWithFormat:@"%@:%.2f %@",@"利息总额",interest,@"万元"];
                    break;
                case 2:
                    cell.textLabel.text = [NSString stringWithFormat:@"%@:%.2f %@",@"每月还款",benXiPayOfMonth,@"元"];
                    break;

            }
            break;
        case LoanTypeShangYE_BenJin:
            switch (row) {
                case 0:
                    cell.textLabel.text = [NSString stringWithFormat:@"%@:%.2f %@",@"还款总额",allPaymoney,@"万元"];
                    break;
                case 1:
                    cell.textLabel.text = [NSString stringWithFormat:@"%@:%.2f %@",@"利息总额",interest,@"万元"];
                    break;
                case 2:
                    firstLabel.text = [NSString stringWithFormat:@"%.2f",[firstMonthPayMoney doubleValue]];
                    secondLabel.text = [NSString stringWithFormat:@"%.2f",[secondMonthPayMoney doubleValue]];
                    n1Label.text = [NSString stringWithFormat:@"%.2f",[theN1MonthPayMoney doubleValue]];
                    lastLabel.text = [NSString stringWithFormat:@"%.2f",[theLastMonthPayMoney doubleValue]];
                    
                    n1MonthLabel.text = [NSString stringWithFormat:@"%@%d%@",@"第",count-1,@"月"];
                    lastMonthLabel.text = [NSString stringWithFormat:@"%@%d%@",@"第",count,@"月"];
                    break;
                    
            }
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSInteger row = [indexPath row];
//    NSUserDefaults *loanParameter = [NSUserDefaults standardUserDefaults];
//    NSNumber *rates = [[NSNumber alloc]initWithInteger:row];
//    [loanParameter setObject: rates forKey:@"rates"];
//    [self.navigationController popViewControllerAnimated:YES];
}

@end
