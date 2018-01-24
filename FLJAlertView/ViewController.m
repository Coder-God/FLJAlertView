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
#import "FLJPickerViewController.h"
#import "RelatedPickerViewController.h"
#import "FLJQRCodeViewController.h"
#import "FLJPhotoAlbumViewController.h"

@interface ViewController ()

@property(nonatomic,strong)NSMutableArray* dataSource;

@property(nonatomic,strong)UIButton* btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.clipsToBounds = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSource = [NSMutableArray arrayWithObjects:@"modalViewController",@"alertViewController",@"一级pickerview",@"二级联动的pickerview",@"二维码",@"相册", nil];
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
            FLJModalViewController* VC = [FLJModalViewController creatAlertVC] ;
            [self presentViewController:VC animated:YES completion:^{
            }];
        }
            break;
        case 1:
        {
            FLJAlertViewController* VC = [FLJAlertViewController alertViewControllerWithTitle:@"带我去方法" description:@"fwefwef"];
            [self presentViewController:VC animated:YES completion:^{
            }];
        }
            break;
        case 2:
        {
            NSMutableArray* numArray = [[NSMutableArray alloc] init];
            for (int i = 0; i<10; i++) {
                NSString* string = [NSString stringWithFormat:@"%d",i];
                [numArray addObject:string];
            }

            FLJPickerViewController* VC = [[FLJPickerViewController alloc] initWithListArray:numArray];
            VC.selectBlock = ^(NSString *selectString) {
                NSLog(@"select==%@",selectString);
            };
            [self presentViewController:VC animated:NO completion:^{
            }];
        }
            break;
        case 3:
        {
            NSMutableArray* numArray = [[NSMutableArray alloc] init];
            for (int i = 0; i<10; i++) {
                NSString* string = [NSString stringWithFormat:@"%d",i];
                [numArray addObject:string];
            }
            NSArray* nameArray = @[@"张三",@"李四",@"王五"];
            NSArray* genderArray = @[@"男",@"女",@"未知"];

            NSArray* relatedArray = @[@{@"数字":numArray},@{@"名字":nameArray},@{@"性别":genderArray}];

            RelatedPickerViewController* VC = [[RelatedPickerViewController alloc] initWithListArray:relatedArray];
            VC.selectBlock = ^(NSString *selectString1, NSString *selectString2) {
                NSLog(@"select==%@==%@",selectString1,selectString2);
            };
            [self presentViewController:VC animated:NO completion:^{
            }];

        }
            break;
        case 4:
        {
            FLJQRCodeViewController* qrVC = [[FLJQRCodeViewController alloc] init];
            [self.navigationController pushViewController:qrVC animated:YES];
        }
            break;
        case 5:
        {
            FLJPhotoAlbumViewController* photoAlbumVC = [[FLJPhotoAlbumViewController alloc] init];
            [self.navigationController pushViewController:photoAlbumVC animated:YES];
        }
            break;

        default:
            break;
    }
}

@end
