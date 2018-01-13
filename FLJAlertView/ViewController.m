//
//  ViewController.m
//  FLJAlertView
//
//  Created by 贾林飞 on 2018/1/9.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import "ViewController.h"
#import "FLJModalViewController.h"
#import "FLJAlertViewController.h"

@interface ViewController ()

@property(nonatomic,strong)UIButton* btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
        
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [btn setTitle:@"弹框" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnDidClicked) forControlEvents:UIControlEventTouchUpInside];
    self.btn = btn;
    [self.view addSubview:btn];
}

-(void)btnDidClicked
{
    FLJModalViewController* VC = [FLJModalViewController creatAlertVC] ;
//    FLJAlertViewController* VC = [FLJAlertViewController alertViewControllerWithTitle:@"带我去方法" description:@"fwefwef"];
    [self presentViewController:VC animated:YES completion:^{
    }];
}

-(void)dissmissBtnDidClicked
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIAlertController* alertVc = [UIAlertController alertControllerWithTitle:@"fwefwef" message:@"fwefwef"    preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction* sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVc addAction:cancelAction];
    [alertVc addAction:sureAction];
    
    [self presentViewController:alertVc animated:YES completion:^{
        
    }];

}


@end
