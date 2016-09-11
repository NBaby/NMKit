//
//  ViewController.m
//  NMPageViewControllerDemo
//
//  Created by nuomi on 16/9/11.
//  Copyright © 2016年 nuomi. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
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

- (IBAction)tapBtn:(id)sender {
    HomeViewController * controller =[[HomeViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
