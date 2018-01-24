//
//  FLJQRCodeViewController.m
//  FLJAlertView
//
//  Created by 贾林飞 on 2018/1/23.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import "FLJQRCodeViewController.h"
#import "FLJScanQRViewController.h"
#import "FLJRecognizeQRViewController.h"
#import "FLJCreatQRViewController.h"

@interface FLJQRCodeViewController ()

@property(nonatomic,strong)NSMutableArray* dataSource;

@end

@implementation FLJQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray arrayWithObjects:@"扫描二维码",@"检测本地图片",@"生成二维码",nil];
}

#pragma mark UITableViewDataSource,UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* reusedID = @"reusedID";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedID];
    }
    
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            FLJScanQRViewController* VC = [[FLJScanQRViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 1:
        {
            FLJRecognizeQRViewController* VC = [[FLJRecognizeQRViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 2:
        {
            FLJCreatQRViewController* VC = [[FLJCreatQRViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;

        default:
            break;
    }
}

@end
