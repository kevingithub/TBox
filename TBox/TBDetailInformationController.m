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
        if (loanType == LoanTypeHunhe_BenJin || loanType == LoanTypeHunhe_BenXi) {
            loanAmountHunHeLabel.hidden = NO;
            loanRatesHunHeLabel.hidden = NO;
        }
    }
    return self;
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
 
    double rate ;
    
    switch (loanType) {
        case LoanTypeShangYE_BenJin:{
            modeOfRepaymentLabel.text = @"等额本金";
            rate = [TBMainViewController getShangYeCurrentRates:monthInt
                                                          style:ratesInt];
            loanRatesLabel.text = [NSString stringWithFormat:@"%.2f%@",rate*100,@"%"];
            loanAmountLabel.text = [NSString stringWithFormat:@"%d",moneyIntShangYe];
//            NSArray *array = (NSArray *)[loanParameter objectForKey:@"sy_bj_paymoney"];
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
        case LoanTypeGongJiJin_BenJin:
            modeOfRepaymentLabel.text = @"等额本金";
            rate = [TBMainViewController getGJJCurrentRates:
                           [monthValue integerValue]];
            loanRatesLabel.text = [NSString stringWithFormat:@"%.2f%@",rate*100,@"%"];
            loanAmountLabel.text = [NSString stringWithFormat:@"%d",moneyIntGongJiJin];
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
        case LoanTypeHunhe_BenJin:
            modeOfRepaymentLabel.text = @"等额本金";
            rate = [TBMainViewController getGJJCurrentRates:
                    [monthValue integerValue]];
            
            loanAmountLabel.text = [NSString stringWithFormat:@"%d",moneyIntGongJiJin +moneyIntShangYe];
            
            break;
        case LoanTypeHunhe_BenXi:
            modeOfRepaymentLabel.text = @"等额本息";
            loanAmountLabel.text = [NSString stringWithFormat:@"%d",moneyIntGongJiJin +moneyIntShangYe];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell && loanType ==LoanTypeGongJiJin_BenXi && loanType == LoanTypeShangYE_BenXi && loanType== LoanTypeHunhe_BenXi) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (!cell && loanType == LoanTypeGongJiJin_BenJin && loanType == LoanTypeShangYE_BenJin && loanType == LoanTypeHunhe_BenJin) {
        NSArray * nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"TBDetailBenJinTableViewCell" owner:self options:nil];
        cell = [nibTableCells objectAtIndex:0];
    }
    
    
    // Configure the cell...
    NSInteger row = [indexPath row];
    
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
            
            break;
            
        case LoanTypeHunhe_BenJin:
            break;
        case LoanTypeHunhe_BenXi:
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
                    cell.textLabel.text = [NSString stringWithFormat:@"%@:%.2f %@",@"每月还款",benXiPayOfMonth,@"元"];
                    break;
                    
            }
            break;
            //TBDetailBenJinTableViewCell
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
