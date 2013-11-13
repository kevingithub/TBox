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
        case LoanTypeShangYE_BenJi:
            modeOfRepaymentLabel.text = @"等额本金";
            rate = [TBMainViewController getShangYeCurrentRates:monthInt
                                                          style:ratesInt];
            loanRatesLabel.text = [NSString stringWithFormat:@"%.2f%@",rate,@"%"];
            loanAmountLabel.text = [NSString stringWithFormat:@"%d",moneyIntShangYe];
            break;
        case LoanTypeShangYE_BenXi:
            modeOfRepaymentLabel.text = @"等额本息";
            rate = [TBMainViewController getShangYeCurrentRates:monthInt
                                                          style:ratesInt];
            loanRatesLabel.text = [NSString stringWithFormat:@"%.2f%@",rate,@"%"];
            loanAmountLabel.text = [NSString stringWithFormat:@"%d",moneyIntShangYe];
            break;
        case LoanTypeGongJiJin_BenJin:
            modeOfRepaymentLabel.text = @"等额本金";
            rate = [TBMainViewController getGJJCurrentRates:
                           [monthValue integerValue]];
            loanRatesLabel.text = [NSString stringWithFormat:@"%.2f%@",rate,@"%"];
            loanAmountLabel.text = [NSString stringWithFormat:@"%d",moneyIntGongJiJin];
            break;
        case LoanTypeGongJiJin_BenXi:
            modeOfRepaymentLabel.text = @"等额本息";
            rate = [TBMainViewController getGJJCurrentRates:
                           [monthValue integerValue]];
            loanRatesLabel.text = [NSString stringWithFormat:@"%.2f%@",rate,@"%"];
            loanAmountLabel.text = [NSString stringWithFormat:@"%d",moneyIntGongJiJin];
            break;
        case LoanTypeHunhe_BenJin:
            modeOfRepaymentLabel.text = @"等额本金";
            loanMonthLabel.text = [NSString stringWithFormat:@"%d",moneyIntGongJiJin +moneyIntShangYe];
            break;
        case LoanTypeHunhe_BenXi:
            modeOfRepaymentLabel.text = @"等额本息";
            loanMonthLabel.text = [NSString stringWithFormat:@"%d",moneyIntGongJiJin +moneyIntShangYe];
            break;
            
        default:
            break;
    }
    
    
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
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    // Configure the cell...
    
//    cell.textLabel.text = (NSString*)[ratesArray objectAtIndex:[indexPath row]];
    
    // Configure the cell...
    cell.textLabel.text = @"test";
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    NSUserDefaults *loanParameter = [NSUserDefaults standardUserDefaults];
    NSNumber *rates = [[NSNumber alloc]initWithInteger:row];
    [loanParameter setObject: rates forKey:@"rates"];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
