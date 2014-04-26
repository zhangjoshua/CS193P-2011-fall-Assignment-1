//
//  CalculatorBrain.m
//  CalculatorAssignment
//
//  Created by Joshua on 14-4-20.
//  Copyright (c) 2014年 Joshua. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property(nonatomic,strong)NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

-(NSMutableArray *)operandStack{
    if (!_operandStack) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}


-(void)pushOperand:(double)operand{
    
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}

-(double)popOperand{
    
    NSNumber *operandObject = [_operandStack lastObject];
    if (_operandStack) [_operandStack removeLastObject];
    return [operandObject doubleValue];
}



-(double)performOperation:(NSString *)operation{
    double result = 0; //perform the operation here
    
    if ([operation isEqualToString:@"+"]) {
        return  [self popOperand] + [self popOperand];
    }else if([@"*" isEqualToString:operation]){
        result = [self popOperand] * [self popOperand];
    }else if([@"/" isEqualToString:operation]){
        double divisor = [self popOperand];
        if(divisor) result = [self popOperand] / divisor;
    }else if([@"-" isEqualToString:operation]){
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    }else if([@"sin" isEqualToString:operation]){
        result = sin([self popOperand]);
    }else if([@"cos" isEqualToString:operation]){
        result = cos([self popOperand]);
    }else if([@"sqrt" isEqualToString:operation]){
        result = sqrt([self popOperand]);
    }else if([@"π" isEqualToString:operation]){
        result = M_PI;
    }else if ([operation isEqualToString:@"log"]){
        result = log([self popOperand]);
    }else if ([operation isEqualToString:@"e"]){
        result = exp([self popOperand]);
    }
    
    [self pushOperand:result];
    return result;
}

-(void)clearStack{
    
    //_operandStack = nil;
    [_operandStack removeAllObjects];
}

@end
