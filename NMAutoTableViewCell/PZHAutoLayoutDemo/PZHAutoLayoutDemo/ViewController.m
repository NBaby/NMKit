//
//  ViewController.m
//  PZHAutoLayoutDemo
//
//  Created by nuomi on 16/7/1.
//  Copyright © 2016年 nuomi. All rights reserved.
//

#import "ViewController.h"
#import "PZHSingleLabelViewController.h"
#import "PZHComplexAutoLayoutController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapLeftBtn:(id)sender {
    PZHSingleLabelViewController * controller =[[PZHSingleLabelViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
    
}
- (IBAction)tapRightBtn:(id)sender {
    PZHComplexAutoLayoutController * controller =[[PZHComplexAutoLayoutController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
