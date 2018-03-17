//
//  Angle.m
//  p08-Shijia-Hu
//
//  Created by shijia hu on 5/8/17.
//  Copyright © 2017 shijia hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Angle.h"

@implementation CALayer (ZNRotationAngleCalculation)

//#warning  these methods can work effective just with round layer.

- (CGFloat)transformAngleWithRotationDirection:(BOOL)clockwise {
    return clockwise ? [self transformRotationAngle] : 2.0f * M_PI - [self transformRotationAngle];
}

- (CGFloat)transformRotationAngle {
    CGFloat degreeAngle = - atan2f(self.presentationLayer.transform.m21, self.presentationLayer.transform.m22);
    
    if (degreeAngle < 0.0f) {
        degreeAngle += (2.0f * M_PI);
    }
    
    return degreeAngle;
}

- (CGPoint)convertPointWhenRotatingWithBenchmarkPoint:(CGPoint)point roundRadius:(CGFloat)radius {
    CGFloat rotationAngle = [self.presentationLayer transformRotationAngle];
    
    return CGPointMake(point.x + sinf(rotationAngle) * radius, point.y - radius + cosf(rotationAngle) * radius);
}

@end
