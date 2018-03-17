//
//  Angle.h
//  p08-Shijia-Hu
//
//  Created by shijia hu on 5/8/17.
//  Copyright © 2017 shijia hu. All rights reserved.
//

#ifndef Angle_h
#define Angle_h

#import <UIKit/UIKit.h>

@interface CALayer (ZNRotationAngleCalculation)

- (CGFloat)transformAngleWithRotationDirection:(BOOL)clockwise;

- (CGPoint)convertPointWhenRotatingWithBenchmarkPoint:(CGPoint)point roundRadius:(CGFloat)radius;

@end
#endif /* Angle_h */
