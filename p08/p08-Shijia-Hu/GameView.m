//
//  GameView.m
//  p08-Shijia-Hu
//
//  Created by shijia hu on 5/8/17.
//  Copyright © 2017 shijia hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameView.h"
#import "Angle.h"

#define kCentralAxisLayerWidth  (self.frame.size.width / 6.0f)
#define kStrokeRoundRadius      (2.0f * kCentralAxisLayerWidth + kTopRoundRadius)
#define kTopRoundRadius         10.0f

@interface GameView ()

@property (strong, nonatomic) UIView *showProcessView;
@property (strong, nonatomic) UILabel *oddRoundsLabel;
@property (strong, nonatomic) UIButton *restart;
@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) UIBezierPath *arrowStrokePath;

@property (strong, nonatomic) CAShapeLayer *centralAxisLayer;

@property (strong, nonatomic) CAKeyframeAnimation *rotation;

@end

@implementation GameView {
    NSUInteger _oddRounds;
    NSUInteger _count;
    NSUInteger _tempOddRounds;
    NSUInteger _tempX;
    NSUInteger _tempY;
    NSInteger _flag;
    NSMutableArray<NSValue *> *_strokeRects;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        _strokeRects = [NSMutableArray array];
        _oddRounds = 10;
        _tempOddRounds = _oddRounds;
        _tempX = 0;
        _tempY = 0;
        _count = 0;
        _flag = 1;
        
        
        [self.layer addSublayer:self.centralAxisLayer];
        
        [self addSubview:self.showProcessView];
        [self addSubview:self.oddRoundsLabel];
        
    }
    
    return self;
}

- (UIView *)showProcessView {
    if (!_showProcessView) {
        _showProcessView = [[UIView alloc] init];
        _showProcessView.backgroundColor = [UIColor clearColor];
        _showProcessView.hidden = YES;
        
        UIView *roundBottomView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 2.0f * kTopRoundRadius, 2.0f * kTopRoundRadius)];
        roundBottomView.center = CGPointMake(kTopRoundRadius, 3.0f / 2.0f * kCentralAxisLayerWidth + kTopRoundRadius);
        roundBottomView.backgroundColor = [UIColor blackColor];
        roundBottomView.layer.cornerRadius = kTopRoundRadius;
        roundBottomView.layer.masksToBounds = YES;
        
        [_showProcessView addSubview:roundBottomView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 2.0f, 3.0f / 2.0f * kCentralAxisLayerWidth)];
        lineView.center = CGPointMake(kTopRoundRadius, 3.0f / 4.0f * kCentralAxisLayerWidth);
        lineView.backgroundColor = [UIColor blackColor];
        
        [_showProcessView addSubview:lineView];
    }
    
    return _showProcessView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.centralAxisLayer.frame = CGRectMake(0.0f, 0.0f, kCentralAxisLayerWidth, kCentralAxisLayerWidth);
    self.centralAxisLayer.position = self.center;
    
    self.oddRoundsLabel.frame = CGRectMake(0.0f, 0.0f, 2.0f * kTopRoundRadius, 2.0f * kTopRoundRadius);
    self.oddRoundsLabel.center = CGPointMake(self.center.x, self.center.y + kCentralAxisLayerWidth / 2.0f + 3.0f / 2.0f * kCentralAxisLayerWidth + 7.0f * kTopRoundRadius);
    self.oddRoundsLabel.layer.cornerRadius = kTopRoundRadius;
    
    self.showProcessView.frame = CGRectMake(0.0f, 0.0f, 2.0f * kTopRoundRadius, 3.0f / 2.0f * kCentralAxisLayerWidth + 2.0f * kTopRoundRadius);
    self.showProcessView.center = CGPointMake(self.center.x, self.oddRoundsLabel.center.y - 3.0f / 4.0f * kCentralAxisLayerWidth);
}


- (CAShapeLayer *)centralAxisLayer {
    if (!_centralAxisLayer) {
        _centralAxisLayer = [CAShapeLayer layer];
        _centralAxisLayer.backgroundColor = [UIColor blackColor].CGColor;
        _centralAxisLayer.cornerRadius = self.frame.size.width / 12.0f;
        _centralAxisLayer.path = self.arrowStrokePath.CGPath;
        _centralAxisLayer.lineWidth = 2.0f;
        _centralAxisLayer.strokeColor = [UIColor blackColor].CGColor;
        _centralAxisLayer.fillColor = [UIColor blackColor].CGColor;
        
        [_centralAxisLayer addAnimation:self.rotation forKey:@"rotation"];
    }
    
    return _centralAxisLayer;
}
- (UIBezierPath *)arrowStrokePath {
    if (!_arrowStrokePath) {
        _arrowStrokePath = [UIBezierPath bezierPath];
        
        CGPoint centralAxisStrokeCenter = CGPointMake(kCentralAxisLayerWidth / 1.0f, kCentralAxisLayerWidth/2);
        [_arrowStrokePath moveToPoint:centralAxisStrokeCenter];
        //////////
        //_tempX = _tempX + 50;
        _tempX = 105;
        _tempY = 105;
        CGPoint strokeEndPoint = CGPointMake(centralAxisStrokeCenter.x + _tempX , centralAxisStrokeCenter.y - _tempY  + kStrokeRoundRadius - kCentralAxisLayerWidth / 2.0f);
        
        [_arrowStrokePath addLineToPoint:strokeEndPoint];
        
        [_arrowStrokePath moveToPoint:strokeEndPoint];
        
        [_arrowStrokePath addArcWithCenter:CGPointMake(strokeEndPoint.x, strokeEndPoint.y) radius:kTopRoundRadius startAngle:0.0f endAngle:2.0f * M_PI clockwise:YES];
        
        [_strokeRects addObject:[NSValue valueWithCGRect:CGRectMake(strokeEndPoint.x - kTopRoundRadius, strokeEndPoint.y - kTopRoundRadius, 10.0f, 20.0f)]];
        
        //anther stroke
        CGPoint centralAxisStrokeCenter1 = CGPointMake(kCentralAxisLayerWidth / 2.0f, kCentralAxisLayerWidth);
        
        CGPoint centralAxisStrokeCenter2 = CGPointMake(kCentralAxisLayerWidth / 2.0f, kCentralAxisLayerWidth/2);
        
        
        
        
        
        
        CGPoint centralAxisStrokeCenter3 = CGPointMake(kCentralAxisLayerWidth / 2.0f, kCentralAxisLayerWidth);
        
        CGPoint centralAxisStrokeCenter4 = CGPointMake(kCentralAxisLayerWidth / 2.0f, kCentralAxisLayerWidth);
        switch (_count) {
            case 1:
                
                [_arrowStrokePath moveToPoint:centralAxisStrokeCenter1];
                CGPoint strokeEndPoint1 = CGPointMake(centralAxisStrokeCenter1.x  , centralAxisStrokeCenter1.y   + kStrokeRoundRadius - kCentralAxisLayerWidth / 2.0f);
                
                [_arrowStrokePath addLineToPoint:strokeEndPoint1];
                
                [_arrowStrokePath moveToPoint:strokeEndPoint1];
                
                [_arrowStrokePath addArcWithCenter:CGPointMake(strokeEndPoint1.x, strokeEndPoint1.y) radius:kTopRoundRadius startAngle:0.0f endAngle:2.0f * M_PI clockwise:YES];
                
                [_strokeRects addObject:[NSValue valueWithCGRect:CGRectMake(strokeEndPoint1.x - kTopRoundRadius, strokeEndPoint1.y - kTopRoundRadius, 10.0f, 20.0f)]];
                break;
            case 2:
                [_arrowStrokePath moveToPoint:centralAxisStrokeCenter1];
                strokeEndPoint1 = CGPointMake(centralAxisStrokeCenter1.x  , centralAxisStrokeCenter1.y   + kStrokeRoundRadius - kCentralAxisLayerWidth / 2.0f);
                
                [_arrowStrokePath addLineToPoint:strokeEndPoint1];
                
                [_arrowStrokePath moveToPoint:strokeEndPoint1];
                
                [_arrowStrokePath addArcWithCenter:CGPointMake(strokeEndPoint1.x, strokeEndPoint1.y) radius:kTopRoundRadius startAngle:0.0f endAngle:2.0f * M_PI clockwise:YES];
                
                [_strokeRects addObject:[NSValue valueWithCGRect:CGRectMake(strokeEndPoint1.x - kTopRoundRadius, strokeEndPoint1.y - kTopRoundRadius, 10.0f, 20.0f)]];
                
                
                
                
                [_arrowStrokePath moveToPoint:centralAxisStrokeCenter2];
                CGPoint strokeEndPoint2 = CGPointMake(centralAxisStrokeCenter1.x-135  , centralAxisStrokeCenter1.y -135  + kStrokeRoundRadius - kCentralAxisLayerWidth / 2.0f);
                
                [_arrowStrokePath addLineToPoint:strokeEndPoint2];
                
                [_arrowStrokePath moveToPoint:strokeEndPoint2];
                
                [_arrowStrokePath addArcWithCenter:CGPointMake(strokeEndPoint2.x, strokeEndPoint2.y) radius:kTopRoundRadius startAngle:0.0f endAngle:2.0f * M_PI clockwise:YES];
                
                [_strokeRects addObject:[NSValue valueWithCGRect:CGRectMake(strokeEndPoint2.x - kTopRoundRadius, strokeEndPoint2.y - kTopRoundRadius, 10.0f, 20.0f)]];
                
                break;
            default:
                break;
        }
        
    }
    
    return _arrowStrokePath;
}

- (CAKeyframeAnimation *)rotation {
    if (!_rotation) {
        _rotation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        _rotation.values = @[@0.0f, @(2.0f * M_PI)];
        _rotation.duration = 5.0f;
        _rotation.removedOnCompletion = NO;
        _rotation.repeatCount = INFINITY;
        _rotation.fillMode = kCAFillModeForwards;
    }
    
    return _rotation;
}

- (UILabel *)oddRoundsLabel {
    if (!_oddRoundsLabel) {
        _oddRoundsLabel = [[UILabel alloc] init];
        _oddRoundsLabel.layer.cornerRadius = kTopRoundRadius;
        _oddRoundsLabel.layer.masksToBounds = YES;
        _oddRoundsLabel.backgroundColor = [UIColor blackColor];
        _oddRoundsLabel.textColor = [UIColor whiteColor];
        _oddRoundsLabel.textAlignment = NSTextAlignmentCenter;
        _oddRoundsLabel.font = [UIFont systemFontOfSize:13.0f];
        _oddRoundsLabel.text = [NSString stringWithFormat:@"%zd", _oddRounds];
    }
    
    return _oddRoundsLabel;
}

- (void)changedOddRounds {
    if(_flag == 1 ){
        self.oddRoundsLabel.text = [NSString stringWithFormat:@"%zd", --_oddRounds];
    }
}

- (BOOL)isIntersectedStrokedRectWithCurrentRect:(CGRect)currentRect {
    __block BOOL result = NO;
    
    [_strokeRects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!(*stop)) {
            CGRect preRect = [obj CGRectValue];
            
            result = CGRectIntersectsRect(preRect, currentRect);
            
            if (result) {
                *stop = YES;
            }
        }
    }];
    
    [_strokeRects addObject:[NSValue valueWithCGRect:currentRect]];
    
    return result;
}

- (void)gameOver {
    self.showProcessView.hidden = YES;
    [self.centralAxisLayer removeAnimationForKey:@"rotation"];
    _flag = 0;
}
- (void)btnClick:(UIButton *)button{
    //button.selected = !button.selected;
    _oddRounds = _tempOddRounds;
    _flag = 1;
    button.hidden = NO;
    [self restartGame];
    button.hidden = YES;
    
}



- (void)restartButton{
    
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    _button.frame=CGRectMake(130,100,100,30);
    //button.backgroundColor = [UIColor ];
    _button.backgroundColor = [UIColor colorWithRed:255.0/255 green:248.0/255 blue:220.0/255 alpha:1.0];
    [_button setTitle:@"restart"forState:UIControlStateNormal];
    
    [_button setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    _button.titleLabel.font=[UIFont systemFontOfSize:17];

    _button.enabled =YES;
    //角度位5
    
    _button.layer.cornerRadius=5;
    
    _button.layer.borderWidth =1;

    _button.clipsToBounds=YES;
    [self addSubview:_button];
    [_button addTarget:self action:@selector(btnClick:)forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)restartGame {
    
    
    self.oddRoundsLabel.text = [NSString stringWithFormat:@"%zd", _oddRounds];
    
    self.arrowStrokePath = nil;
    self.centralAxisLayer.path = nil;
    
    [_strokeRects removeAllObjects];
    
    self.centralAxisLayer.path = self.arrowStrokePath.CGPath;
    [self.centralAxisLayer addAnimation:self.rotation forKey:@"rotation"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.1f animations:^{
        
        if (_flag ) {
            self.showProcessView.hidden = NO;
        }
        
        
        self.showProcessView.center = CGPointMake(self.center.x, self.center.y + kCentralAxisLayerWidth / 2.0f + 3.0f / 4.0f * kCentralAxisLayerWidth + kTopRoundRadius);
    } completion:^(BOOL finished) {
        self.showProcessView.hidden = YES;
        
        self.showProcessView.center = CGPointMake(self.oddRoundsLabel.center.x, self.oddRoundsLabel.center.y - 3.0f / 4.0f * kCentralAxisLayerWidth);
        
        CGPoint strokeStartPoint = [self.centralAxisLayer convertPointWhenRotatingWithBenchmarkPoint:CGPointMake(kCentralAxisLayerWidth / 2.0f, kCentralAxisLayerWidth)  roundRadius:kCentralAxisLayerWidth / 2.0f];
        CGPoint strokeEndPoint = [self.centralAxisLayer convertPointWhenRotatingWithBenchmarkPoint:CGPointMake(kCentralAxisLayerWidth / 2.0f, kCentralAxisLayerWidth / 2.0f + kStrokeRoundRadius) roundRadius:kStrokeRoundRadius];
        
        UIBezierPath *strokeBezier = [UIBezierPath bezierPath];
        
        [strokeBezier moveToPoint:strokeStartPoint];
        [strokeBezier addLineToPoint:strokeEndPoint];
        
        [strokeBezier moveToPoint:strokeEndPoint];
        [strokeBezier addArcWithCenter:strokeEndPoint radius:kTopRoundRadius startAngle:0.0f endAngle:2.0f * M_PI clockwise:YES];
        
//        [_arrowStrokePath addArcWithCenter:CGPointMake(strokeEndPoint.x, strokeEndPoint.y) radius:kTopRoundRadius startAngle:0.0f endAngle:2.0f * M_PI clockwise:YES];
        
        [self changedOddRounds];
        
        [self.arrowStrokePath appendPath:strokeBezier];
        self.centralAxisLayer.path = self.arrowStrokePath.CGPath;
        
        CGRect currentStrokeRect = CGRectMake(strokeEndPoint.x - kTopRoundRadius, strokeEndPoint.y - kTopRoundRadius, 20.0f, 20.0f);
        
        if ([self isIntersectedStrokedRectWithCurrentRect:currentStrokeRect] && _flag) {
            [self gameOver];
            [self restartButton];
            
        }else if (_oddRounds==0) {
            _tempOddRounds = _tempOddRounds + 3;
            if (_tempOddRounds == 16) {
                _count++;
            }
            if (_tempOddRounds == 22) {
                _count++;
            }
            _oddRounds = _tempOddRounds;
            _button.hidden = YES;
            [self restartGame];
            _flag = 1;
        };

    }];
}

@end;
