//
//  FLJPickerViewController.m
//  FLJAlertView
//
//  Created by 贾林飞 on 2018/1/23.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import "FLJPickerViewController.h"

#define kPickerViewHeight 230

@interface FLJPickerViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong)UIView* bgView;

@property(nonatomic,strong)UIPickerView* pickerView;

@property(nonatomic,strong)NSMutableArray* dataSource;

@property(nonatomic,strong)UIToolbar* toolBar;

@property(nonatomic,assign)NSInteger selectRow;

@end

@implementation FLJPickerViewController

-(instancetype)initWithListArray:(NSArray *)array
{
    if (self == [super init]) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self.dataSource addObjectsFromArray:array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
        
    UIToolbar* toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-kPickerViewHeight-44, self.pickerView.bounds.size.width, 44)];
    
    UIBarButtonItem* cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
    UIBarButtonItem* fix = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem* sure = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(sureAction)];
    toolBar.items = @[cancel,fix,sure];
    self.toolBar = toolBar;
    
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.pickerView];
    [self.view addSubview:toolBar];
    
    [self.pickerView selectRow:4 inComponent:0 animated:YES];
    [self pickerView:self.pickerView didSelectRow:4 inComponent:0];
}

#pragma mark UIPickerViewDataSource, UIPickerViewDelegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataSource.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.dataSource[row];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectRow = row;
}

#pragma mark  private

-(void)sureAction
{
    NSString* string = self.dataSource[self.selectRow];
    !self.selectBlock?:self.selectBlock(string);
    [self cancelAction];
}

-(void)cancelAction
{
    [UIView animateWithDuration:.2f animations:^{
        
        self.bgView.alpha = .0f;
        self.pickerView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, self.pickerView.bounds.size.height);
        self.toolBar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, self.toolBar.bounds.size.height);

    } completion:^(BOOL finished) {
        if (self.presentingViewController) {
            [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    }];
}

#pragma mark  懒加载

-(UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:self.view.bounds];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = .3f;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAction)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

-(UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-kPickerViewHeight, [UIScreen mainScreen].bounds.size.width, kPickerViewHeight)];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
@end
