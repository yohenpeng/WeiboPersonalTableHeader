//
//  ViewController.m
//  testTableHeader
//
//  Created by pengehan on 17/1/12.
//  Copyright © 2017年 pengehan. All rights reserved.
//

#import "ViewController.h"

#define CellId @"tableCellId"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *headerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setUpSubViews];
}

-(void)setUpSubViews{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.backgroundColor = [UIColor lightGrayColor];
        _tableView.clipsToBounds = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = self.headerView;
        [_tableView sendSubviewToBack:self.headerView];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellId];
    }
    return _tableView;
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150)];
        _headerView.backgroundColor = [UIColor clearColor];
        
        
        UIImage *logo = [self scaleImage:[UIImage imageNamed:@"avatar"] toSize:CGSizeMake(50, 50)];
        
        UIImageView *avatarImage = [[UIImageView alloc]initWithImage:logo];
        avatarImage.frame = CGRectMake((_headerView.frame.size.width - logo.size.width)/2.0, (_headerView.frame.size.height - logo.size.height)/2.0, logo.size.width, logo.size.height);
        
        [_headerView addSubview:avatarImage];
        
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"image"]];
        imageView.frame = CGRectMake(0, -50, self.view.bounds.size.width, 100 + 150);
        imageView.tag = 100;
        
        [_headerView addSubview:imageView];
        [_headerView sendSubviewToBack:imageView];
        
    }
    return _headerView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint contentOffset = scrollView.contentOffset;
    if (contentOffset.y <= 0) {
        UIView *view = [self.tableView.tableHeaderView viewWithTag:100];
        view.transform = CGAffineTransformMakeTranslation(0, MAX(contentOffset.y/2, -50));
    }
}

-(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size{
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddRect(context, CGRectMake(0, 0, size.width, size.height));
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    
    CGContextFillPath(context);

    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return retImage;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld个",(long)indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
