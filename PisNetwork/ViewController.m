//
//  ViewController.m
//  PisNetwork
//
//  Created by newegg on 15/8/12.
//  Copyright (c) 2015年 newegg. All rights reserved.
//

#import "ViewController.h"
#import "BaseBusinessWrapper.h"
#import "BaseClass.h"
@interface ViewController ()

@property (strong, nonatomic) BaseClass *baseClass;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *url = [NSString stringWithFormat:@"https://api.douban.com/v2/music/search?q=%@",@"人"];
    [BaseBusinessWrapper getWithUrl:url resultType:[BaseClass class] startCallBack:^{
        NSLog(@"开始加载了");
    } successCallBack:^(id data) {
        self.baseClass = [BaseClass modelObjectWithDictionary:data];
        
    } errorCallBack:^(ServiceError *error) {
        NSLog(@"加载失败");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
