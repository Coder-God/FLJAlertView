//
//  FLJCreatQRViewController.m
//  FLJAlertView
//
//  Created by 贾林飞 on 2018/1/24.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import "FLJCreatQRViewController.h"
#import "UIViewController+MessageAlert.h"

#define kRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define kRandomColor kRGBColor(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))

#define qrImageSize CGSizeMake(300,300)

@interface FLJCreatQRViewController ()<UITextFieldDelegate>

@property(nonatomic,strong)UITextField* textField;

@property (strong, nonatomic)UIImageView *imageView;

@property(nonatomic,strong)UIButton* creatBtn;

@property(nonatomic,strong)UIButton* changeColorBtn;

@property(nonatomic,strong)UIButton* addSmallImageBtn;

@end

@implementation FLJCreatQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self creatBtnDidClicked];
    
    return YES;
}

/** 生成指定大小的黑白二维码 */
- (UIImage *)createQRImageWithString:(NSString *)string size:(CGSize)size
{
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //    NSLog(@"%@",qrFilter.inputKeys);
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    CIImage *qrImage = qrFilter.outputImage;
    //放大并绘制二维码 (上面生成的二维码很小，需要放大)
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    //翻转一下图片 不然生成的QRCode就是上下颠倒的
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    
    return codeImage;
}

/** 为二维码改变颜色 */
- (UIImage *)changeColorForQRImage:(UIImage *)image backColor:(UIColor *)backColor frontColor:(UIColor *)frontColor
{
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",[CIImage imageWithCGImage:image.CGImage],
                             @"inputColor0",[CIColor colorWithCGColor:frontColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:backColor.CGColor],
                             nil];
    
    return [UIImage imageWithCIImage:colorFilter.outputImage];
}

/** 在二维码中心加一个小图 */
- (UIImage *)addSmallImageForQRImage:(UIImage *)qrImage
{
    UIGraphicsBeginImageContext(qrImage.size);
    
    [qrImage drawInRect:CGRectMake(0, 0, qrImage.size.width, qrImage.size.height)];
    
    UIImage *image = [UIImage imageNamed:@"small"];
    
    CGFloat imageW = 50;
    CGFloat imageX = (qrImage.size.width - imageW) * 0.5;
    CGFloat imgaeY = (qrImage.size.height - imageW) * 0.5;
    
    [image drawInRect:CGRectMake(imageX, imgaeY, imageW, imageW)];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}

//点击生成按钮
-(void)creatBtnDidClicked
{
    if (self.textField.text.length>0) {
        self.imageView.image = [self createQRImageWithString:self.textField.text size:qrImageSize];
        [self.textField endEditing:YES];
    }else
    {
        [self showAlertWithTitle:@"" message:@"请先输入文字" handler:nil];
    }
}

//点击改变颜色
- (void)changeColorButtonDidClick:(UIButton *)sender
{
    UIImage *image = [self createQRImageWithString:self.textField.text size:qrImageSize];
    
    self.imageView.image = [self changeColorForQRImage:image backColor:kRandomColor frontColor:kRandomColor];
}

//添加小图
- (void)addSamllImageButtonDidClick:(UIButton *)sender
{
    self.imageView.image = [self addSmallImageForQRImage:self.imageView.image];
}

-(void)setupSubViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 88, 200, 30)];
    self.textField.layer.borderWidth = 1.f;
    self.textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textField.placeholder = @"输入要生成二维码的文字";
    self.textField.font = [UIFont systemFontOfSize:13];
    self.textField.textColor = [UIColor blueColor];
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
    
    self.creatBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.textField.frame)+10, CGRectGetMinY(self.textField.frame), 80, 30)];
    self.creatBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.creatBtn setTitle:@"生成二维码" forState:UIControlStateNormal];
    [self.creatBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.creatBtn addTarget:self action:@selector(creatBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.creatBtn];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.textField.frame)+20, self.view.bounds.size.width-20, self.view.bounds.size.width-20)];
    
    [self.view addSubview:self.imageView];
    
    self.changeColorBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.imageView.frame), CGRectGetMaxY(self.imageView.frame)+10, 60, 44)];
    self.changeColorBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.changeColorBtn setTitle:@"改变颜色" forState:UIControlStateNormal];
    [self.changeColorBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.changeColorBtn addTarget:self action:@selector(changeColorButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.changeColorBtn];

    self.addSmallImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView.frame)-60, CGRectGetMinY(self.changeColorBtn.frame), 60, 44)];
    self.addSmallImageBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.addSmallImageBtn setTitle:@"添加小图" forState:UIControlStateNormal];
    [self.addSmallImageBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.addSmallImageBtn addTarget:self action:@selector(addSamllImageButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addSmallImageBtn];

}

@end
