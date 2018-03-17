//
//  ViewController.m
//  p08-Shijia-Hu
//
//  Created by shijia hu on 5/6/17.
//  Copyright © 2017 shijia hu. All rights reserved.
//

#import "ViewController.h"
#import "GameView.h"
@interface ViewController ()

@property (strong, nonatomic) GameView *insertPinView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.insertPinView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (GameView *)insertPinView {
    if (!_insertPinView) {
        _insertPinView = [[GameView alloc] initWithFrame:self.view.bounds];
        _insertPinView.backgroundColor = [UIColor grayColor];
    }
    
    return _insertPinView;
}

@end
