//
//  TBMainViewController.m
//  TBox
//
//  Created by kevin chen on 13-10-24.
//  Copyright (c) 2013年 MMS. All rights reserved.
//

#import "TBMainViewController.h"
#import "TBMonthListViewController.h"
#import "TBLendingRatesViewController.h"
#import "TBDetailInformationController.h"

@interface TBMainViewController ()
{
    /*
     2012.07.06
    
     一、短期贷款
     1.六个月（含）5.6%
     2.六个月至一年（含）6%
     二、中长期贷款
     1.一至三年（含）6.15%
     2.三至五年（含）6.4%
     3.五年以上 6.55%
     
     2012.07.06
     5年以内(含)
     4.00
     
     5年以上
     4.50
     
     等额本息计算公式：
     〔贷款本金×月利率×（1＋月利率）＾还款月数〕÷〔（1＋月利率）＾还款月数－1〕
     等额本金计算公式：
     每月还款金额 = （贷款本金 ÷ 还款月数）+（本金 — 已归还本金累计额）×每月利率
     
     
     其中＾符号表示乘方。
    */
}
-(IBAction)firstViewButtonAction:(id)sender;

-(float)getBenXiMoney:(NSInteger)money month:(NSInteger)month rates:(double)rates;
-(NSArray*)getPayMoney:(NSUInteger)money month:(NSInteger)month rates:(double)rates;
//-(double)getCurrentRates:(NSInteger)year;

@end

@implementation TBMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _mainSegment.selectedSegmentIndex = 0;
//    NSString *monthStr = [NSString stringWithFormat:@"%d",row];
//    [loanParameter setObject: monthStr forKey:@"month"];
    // Do any additional setup after loading the view from its nib.
    loanMonthArray = [[NSArray alloc]initWithObjects:@"半年(6个月)",@"一年",@"二年",@"三年",@"四年",@"五年",@"六年",@"七年",@"八年",@"九年",@"十年",
                      @"十一年",@"十二年",@"十三年",@"十四年",@"十五年",@"十六年",@"十七年",@"十八年",@"十九年",@"二十年",@"二十年",@"二十一年",@"二十二年",@"二十三年",@"二十四年",@"二十五年",@"二十六年",@"二十七年",@"二十八年",@"二十九年",@"三十年",nil];
    
    ratesArray = [[NSArray alloc]initWithObjects:@"12年7月6日基准利率",@"12年7月6日优惠利率(85折)",
                  @"12年7月6日优惠利率(9折)",@"12年7月6日上浮利率(1.1倍)", nil];
    
    [_mainSegment addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
    _firstView.hidden = YES;
    UIBarButtonItem *getResultBT = [[UIBarButtonItem alloc] initWithTitle:@"计算结果" style:UIBarButtonItemStyleDone target:self action:@selector(getResultButton:)];
    self.navigationItem.rightBarButtonItem = getResultBT;
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"will appear");
    NSUserDefaults *loanParameter = [NSUserDefaults standardUserDefaults];
    NSString *monthValue = (NSString*)[loanParameter objectForKey:@"month"];
    NSInteger month = [monthValue integerValue];
    monthValue = [loanMonthArray objectAtIndex:month];
    [_DKYearButton setTitle:monthValue forState:UIControlStateNormal];
    
    NSString *ratesValue = (NSString *)[loanParameter objectForKey:@"rates"];
    NSInteger rates = [ratesValue integerValue];
    ratesValue = [ratesArray objectAtIndex:rates];
    [_DKFeeLabel setTitle:ratesValue forState:UIControlStateNormal];
}
-(void)segmentAction:(UISegmentedControl *)segment{
    NSLog(@"pay method");
}

- (void)valueChanged:(UISegmentedControl *)segment {
    
    if(segment.selectedSegmentIndex == 0) {
        NSLog(@"segment selected 0");
        [_tableView reloadData];
        type = LoanTypeShangYE;
    }else if(segment.selectedSegmentIndex == 1){
        NSLog(@"segment selected 1");
        [_tableView reloadData];
        type = LoanTypeGongJiJin;
    }else if(segment.selectedSegmentIndex == 2){
        NSLog(@"segment selected 2");
        [_tableView reloadData];
        type = LoanTypeHunhe;
    }
}

//first view done
-(IBAction)firstViewButtonAction:(id)sender{
   
    
}


/*
 等额本息计算公式：
 〔贷款本金×月利率×（1＋月利率）＾还款月数〕÷〔（1＋月利率）＾还款月数－1〕
 */
-(float)getBenXiMoney:(NSInteger)money month:(NSInteger)month rates:(double)rates{
//    float MonthlyRate;

            double firstFloat = 1.0,monthRates;
            double result_1,result_2;
            
            monthRates =rates/12;
            for (int i = 1; i < month+1; i ++) {
                firstFloat *= (1+monthRates);
            }
            result_1 = money*monthRates*firstFloat;
            result_2 = result_1/(firstFloat-1);
            return result_2;
}
/*
 一、短期贷款
 1.六个月（含）5.6%
 2.六个月至一年（含）6%
 二、中长期贷款
 1.一至三年（含）6.15%
 2.三至五年（含）6.4%
 3.五年以上 6.55%
 
 2012.07.06
 5年以内(含)
 4.00
 
 5年以上
 4.50
 */
-(double)getShangYeCurrentRates:(NSInteger)month style:(NSInteger)style
{
    double rates ;
    if(month<=6)
        rates = 0.056;
    else if(month <=12)
        rates = 0.06;
    else if(month <=36)
        rates = 0.0615;
    else if(month <=60)
        rates = 0.064;
    else if(month >60)
        rates = 0.0655;
    switch (style) {
        case 1:
            rates = rates *0.85;
            break;
        case 2:
            rates = rates * 0.9;
            break;
        case 3:
            rates = rates * 1.1;
            break;
        default:
            break;
    }
    return rates;
}
-(double)getGJJCurrentRates:(NSInteger)month
{
    if(month<=60)
        return 0.04;
    else
        return 0.045;
}
/*
 * method:true
 *等额本金计算公式：
 每月还款金额 = （贷款本金 ÷ 还款月数）+（本金 — 已归还本金累计额）×每月利率
 */
-(NSArray*)getPayMoney:(NSUInteger)money
                 month:(NSInteger)month
                 rates:(double)rates{
    double firstFloat = 1.0,monthRates,averageMonth;
    NSMutableArray *monthArray;
    
    monthRates =rates/12;
    averageMonth = money/month;
    
    monthArray = [[NSMutableArray alloc]initWithCapacity:month];
    for (int i = 1; i < month+1; i ++) {
        firstFloat = averageMonth +(money-(i-1)*averageMonth)*monthRates;
        [monthArray addObject:[NSNumber numberWithFloat:firstFloat]];
        
    }
    return monthArray;
}
//获取混合等额本金
- (NSArray *)GetHunHeMoney:(NSUInteger)moneyShangYe
            moneyGongJiJin:(NSUInteger)moneyGongJiJin
                     month:(NSInteger)month {
    double gongJiJinRates,shangYeRates,tempRatesShangYe,tempRatesGongJiJin;
    double averageGongJiJin,averageShangYe;
    double monthRatesGongJiJin,monthRatesShangYe;
    NSMutableArray * monthArray;
    
    monthArray = [[NSMutableArray alloc]initWithCapacity:month];
    gongJiJinRates = [self getGJJCurrentRates:month];
    NSUserDefaults *loanParameter = [NSUserDefaults standardUserDefaults];
    NSNumber *ratesValue = (NSNumber*)[loanParameter objectForKey:@"rates"];
    NSInteger styleRate = [ratesValue integerValue];
    shangYeRates = [self getShangYeCurrentRates:month style:styleRate];
    
    averageGongJiJin = moneyGongJiJin/month;
    averageShangYe = moneyShangYe/month;
    monthRatesGongJiJin = gongJiJinRates/12;
    monthRatesShangYe = shangYeRates/12;
    
    for (int i = 1; i <month +1; i ++) {
        tempRatesShangYe = averageShangYe +
                    (moneyShangYe-(i-1)*averageShangYe) * monthRatesShangYe;
        tempRatesGongJiJin = averageGongJiJin +
        (moneyGongJiJin -(i-1)*averageGongJiJin)*monthRatesGongJiJin;
        
        [monthArray addObject:
         [NSNumber numberWithDouble:
          (tempRatesGongJiJin+tempRatesShangYe)]];
        
    }
    
    
    return monthArray;
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
    switch (_mainSegment.selectedSegmentIndex) {
        case 0:
            return 4;
        case 1:
            return 3;
        case 2:
            return 5;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
     cell.textLabel.text = (NSString*)[ratesArray objectAtIndex:[indexPath row]];
    return cell;
    */
    NSInteger row = [indexPath row];
    NSArray *nibTableCells;
    UITableViewCell *cell;
    // Configure the cell...
    
    // Configure the cell...
    switch (_mainSegment.selectedSegmentIndex) {
        case 0://商贷
            switch (row) {
                case 0:
                {
                    nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"loanCountCell" owner:self options:nil];
                    cell = [nibTableCells objectAtIndex:0];
                    return cell;
                }
                    break;
                case 1:
                {
                    nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"loanYearCell" owner:self options:nil];
                    cell = [nibTableCells objectAtIndex:0];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    return cell;
                }
                    break;
                case 2:
                {
                    nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"loanRatesCell" owner:self options:nil];
                    cell = [nibTableCells objectAtIndex:0];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

                    return cell;
                }
                    break;
                case 3:
                {
                    nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"loanPayMethodCell" owner:self options:nil];
                    cell = [nibTableCells objectAtIndex:0];
                    UISegmentedControl *segment= (UISegmentedControl*)[cell.contentView viewWithTag:11];
                    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
                    return cell;
                }
                    break;
                    
//                default:
//                    break;
            }
            
            break;
        case 1://公积金
            switch (row) {
                case 0:
                    nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"loanCountCell" owner:self options:nil];
                    cell = [nibTableCells objectAtIndex:0];
                    return cell;
                    break;
                case 1:
                    nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"loanYearCell" owner:self options:nil];
                    cell = [nibTableCells objectAtIndex:0];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

                    return cell;
                    break;
                case 2:
                    nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"loanRatesCell" owner:self options:nil];
                    cell = [nibTableCells objectAtIndex:0];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

                    return cell;
                    break;
                    
//                default:
//                    break;
            }

            break;
        case 2://组合
            switch (row) {
                case 0:
                    nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"loanCountCell" owner:self options:nil];
                    cell = [nibTableCells objectAtIndex:0];
                    return cell;
                    break;
                case 1:
                    nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"loanCountCell" owner:self options:nil];
                    cell = [nibTableCells objectAtIndex:0];
                    return cell;
                    break;
                case 2:
                    nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"loanYearCell" owner:self options:nil];
                    cell = [nibTableCells objectAtIndex:0];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

                    return cell;
                    break;
                case 3:
                    nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"loanRatesCell" owner:self options:nil];
                    cell = [nibTableCells objectAtIndex:0];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

                    return cell;
                    break;
                case 4:
                {
                    nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"loanPayMethodCell" owner:self options:nil];
                    cell = [nibTableCells objectAtIndex:0];
                    UISegmentedControl *_segment = (UISegmentedControl*)[cell.contentView viewWithTag:11];
                    [_segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
                    return cell;
                }
                    break;
                    
//                default:
//                    break;
            }
            break;
            
        default:
            break;
    }
    
    return nil;
}
//hide the keyboard
-(void)hideKeyboard
{
    NSIndexPath * index= [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell_0 = [_tableView cellForRowAtIndexPath:index];
    UITextField *field = (UITextField*)[cell_0 viewWithTag:11];
    [field resignFirstResponder];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    TBMonthListViewController *_monthListViewController = [[TBMonthListViewController alloc]init];
    TBLendingRatesViewController *ratesViewController = [[TBLendingRatesViewController alloc]init];
    
    switch (_mainSegment.selectedSegmentIndex) {
        case 0:
            switch (row) {
                case 1://year
                    [self.navigationController pushViewController:_monthListViewController animated:YES];
                    break;
                case 2://rates
                {
                   
                    [self.navigationController pushViewController:ratesViewController animated:YES];

                    break;
                }
                default:
                    break;
            }
            break;
        case 1:
            switch (row) {
                case 1://year
                    [self.navigationController pushViewController:_monthListViewController animated:YES];
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch (row) {
                case 2://year
                    [self.navigationController pushViewController:_monthListViewController animated:YES];
                    break;
                case 3://rates
                    [self.navigationController pushViewController:ratesViewController animated:YES];

                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    
}
#pragma mark - get the result
-(void)getResultButton:(id)sender{
    NSUserDefaults *loanParameter = [NSUserDefaults standardUserDefaults];
    NSNumber *monthValue = (NSNumber*)[loanParameter objectForKey:@"month"];
    NSNumber *ratesValue = (NSNumber*)[loanParameter objectForKey:@"rates"];
    NSInteger _month = [monthValue integerValue];
    NSInteger _rates = [ratesValue integerValue];
    
    switch(_mainSegment.selectedSegmentIndex){
        case 0://商业贷款
        {
            NSIndexPath * _index= [NSIndexPath indexPathForRow:3 inSection:0];
            UITableViewCell *cell = [_tableView cellForRowAtIndexPath:_index];
            UISegmentedControl *segment = (UISegmentedControl*)[cell viewWithTag:11];
            NSInteger selected = segment.selectedSegmentIndex;
            
            NSIndexPath * index= [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *cell_0 = [_tableView cellForRowAtIndexPath:index];
            UITextField *field = (UITextField*)[cell_0 viewWithTag:11];
            NSInteger money = [field.text integerValue];
            double rates = [self getShangYeCurrentRates:_month style:_rates];
            if (selected == 0)//等额本息
            {
                double payMoney = [self getBenXiMoney:money month:_month
                                                rates:rates];
                [loanParameter setObject:
                 [[NSNumber alloc]initWithDouble:payMoney]
                                  forKey:@"sy_bx_paymoney"];
            }
            else//等额本金
            {
                NSArray *payArray = [self getPayMoney:money
                                                month:_month
                                                rates:rates];
                [loanParameter setObject:payArray forKey:@"sy_bj_paymoney"];
            }
            
            return;
        }
            case 1://公积金贷款
        {
            //获取贷款金额
            NSIndexPath *index_1 = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *cell_1 = [_tableView cellForRowAtIndexPath:index_1];
            UITextField *field_1 = (UITextField*)[cell_1 viewWithTag:11];
            NSInteger gjj_money = [field_1.text integerValue];
            //获取还款方式
            NSIndexPath *index_2 = [NSIndexPath indexPathForRow:2 inSection:0];
            UITableViewCell *cell_2 = [_tableView cellForRowAtIndexPath:index_2];
            UISegmentedControl *segment_1 = (UISegmentedControl*)[cell_2 viewWithTag:11];
            NSInteger selected = segment_1.selectedSegmentIndex;
            double rates = [self getGJJCurrentRates:_month ];
            
            if (selected ==0) {
                double gjjPayMoney = [self getBenXiMoney:gjj_money
                                                   month:_month
                                                   rates:_rates];
                [loanParameter setObject:
                 [[NSNumber alloc]initWithDouble:gjjPayMoney ]
                                  forKey:@"gjj_bx_paymoney"];

                
            } else {
                NSArray *gjjArray =[self getPayMoney:gjj_money month:_month rates:rates];
                [loanParameter setObject:gjjArray forKey:@"gjj_bj_paymoney"];
            }
            
            
            break;
        }
        case 2://混合贷款
            
        {
            //获取商业贷款金额
            NSIndexPath *index_1 = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *cell_1 = [_tableView cellForRowAtIndexPath:index_1];
            UITextField *field_1 = (UITextField*)[cell_1 viewWithTag:11];
            NSInteger sy_money = [field_1.text integerValue];
            
            //获取公积金贷款金额
            NSIndexPath *index_2 = [NSIndexPath indexPathForRow:1 inSection:0];
            UITableViewCell *cell_2 = [_tableView cellForRowAtIndexPath:index_2];
            UITextField *field_2 = (UITextField*)[cell_2 viewWithTag:11];
            NSInteger gjj_money = [field_2.text integerValue];
            
            //获取贷款方式
            NSIndexPath *index_3 = [NSIndexPath indexPathForRow:4 inSection:0];
            UITableViewCell *cell_3 = [_tableView cellForRowAtIndexPath:index_3];
            UISegmentedControl *segment_1 = (UISegmentedControl*)[cell_3 viewWithTag:11];
            NSInteger selected = segment_1.selectedSegmentIndex;
            double ratesShangYe = [self getShangYeCurrentRates:_month style:_rates];
            double ratesGongJiJin =[self getGJJCurrentRates:_month];

            if (selected ==0) {
                double hunHeShangYe = [self getBenXiMoney:sy_money
                                                    month:_month
                                                    rates:ratesShangYe];
                
                double hunHeGongJiJin = [self getBenXiMoney:gjj_money
                                                      month:_month
                                                      rates:ratesGongJiJin];
                [loanParameter setObject:
                 [[NSNumber alloc]initWithDouble:(hunHeShangYe+hunHeGongJiJin)]
                                  forKey:@"hh_paymoney"];
                
            } else {
                NSArray *hunHeArray = [self GetHunHeMoney:sy_money
                                           moneyGongJiJin:gjj_money
                                                    month:_month];
                [loanParameter setObject:hunHeArray forKey:@"hh_bj_paymoney"];
            }
            
            break;
        }
            
    }
    switch (_mainSegment.selectedSegmentIndex) {
        case 0:
            type = LoanTypeShangYE;
            break;
        case 1:
            type = LoanTypeGongJiJin;
            break;
        case 2:
            type = LoanTypeHunhe;
            break;
            
    }
    TBDetailInformationController *targetViewController = [[TBDetailInformationController alloc]initWithNib:@"TBDetailInformationController" type:&type];
    
    }

@end
