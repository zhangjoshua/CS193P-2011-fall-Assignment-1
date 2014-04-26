//
//  CalculatorBrain.h
//  CalculatorAssignment
//
//  Created by Joshua on 14-4-20.
//  Copyright (c) 2014年 Joshua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

-(void)pushOperand:(double)operand;
-(double)performOperation:(NSString *)operation;
-(void)clearStack;

@end
