//
//  ViewController.m
//  CalendarView
//
//  Created by baoxiuyizhantong on 15/8/20.
//  Copyright (c) 2015年 BX. All rights reserved.
//

#import "ViewController.h"
#import "CalendarViewController.h"
#import "BXUserHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_click:(id)sender {
    
    CalendarViewController *calendarVC = [[CalendarViewController alloc] init];
    calendarVC.navigationController.navigationBar.translucent = NO;
    [self.navigationController pushViewController:calendarVC animated:YES];
}
@end
