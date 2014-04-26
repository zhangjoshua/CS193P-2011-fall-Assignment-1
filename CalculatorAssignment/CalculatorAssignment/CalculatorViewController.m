//
//  CalculatorViewController.m
//  CalculatorAssignment
//
//  Created by Joshua on 14-4-17.
//  Copyright (c) 2014年 Joshua. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInMiddleOfEnteringANumber;
@property (nonatomic,strong) CalculatorBrain *brain;
@property (nonatomic) BOOL userPressedOperation;
@end


@implementation CalculatorViewController

@synthesize display = _display;
@synthesize allDisplay = _allDisplay;
@synthesize userIsInMiddleOfEnteringANumber = _userIsInMiddleOfEnteringANumber;
@synthesize brain = _brain;
@synthesize userPressedOperation;

-(CalculatorBrain *)brain{
    
    if (!_brain) _brain = [[CalculatorBrain alloc]init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    
    NSString *digit = [sender currentTitle];
    if (self.userIsInMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
        
    } else {
        self.display.text = digit;
        self.userIsInMiddleOfEnteringANumber = YES;
    }
    
    if (self.userPressedOperation) {
            self.allDisplay.text =[self.allDisplay.text substringToIndex:[self.allDisplay.text length] - 1];
        self.userPressedOperation = NO;
    }
    
    if ([self.allDisplay.text isEqualToString:@"0"]) {
        self.allDisplay.text = @"";
    }
    
    self.allDisplay.text = [self.allDisplay.text stringByAppendingString:digit];
    
   
}
- (IBAction)enterPressed {
    
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.allDisplay.text = [self.allDisplay.text stringByAppendingString:@" "];
    self.userIsInMiddleOfEnteringANumber = NO;
    
    if ([self.display.text isEqualToString:@"520"]) {
        
        self.display.text = @"我爱你";
        self.allDisplay.text = @"小兮，我爱你！";
    }
}
- (IBAction)operationPressed:(UIButton *)sender {
    
    if (self.userIsInMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    
    NSString *operation = [sender currentTitle];
    
    self.allDisplay.text = [self.allDisplay.text stringByAppendingString:operation];
    self.allDisplay.text = [self.allDisplay.text stringByAppendingString:@"="];
    self.userPressedOperation = YES;
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g",result];
}
- (IBAction)clearAll {

    self.allDisplay.text = @"0";
    self.display.text = @"0";
    self.userIsInMiddleOfEnteringANumber = NO;
    [self.brain clearStack];

    //self.display.text = nil;
}

- (IBAction)clearPressed {
    
    if (self.display.text){
        
        self.display.text =[self.display.text substringToIndex:[self.display.text length] - 1];
    }
    
    if (self.allDisplay.text) {
        
        self.allDisplay.text =[self.allDisplay.text substringToIndex:[self.allDisplay.text length] - 1];
    }
    
    if ([self.allDisplay.text isEqualToString:@""]) {
        self.allDisplay.text = @"0";
    }
    
    if ([self.display.text isEqualToString:@""])  {
        self.display.text = @"0";
        self.userIsInMiddleOfEnteringANumber = NO;
    }
}
- (IBAction)changeSignPressed {
    
    if (self.userIsInMiddleOfEnteringANumber) {
        self.allDisplay.text = [self.allDisplay.text substringToIndex:[self.allDisplay.text length] - [self.display.text length]];
        
        double currentNumber = [self.display.text doubleValue];
        currentNumber = 0 -currentNumber;
        self.display.text = [NSString stringWithFormat:@"%g",currentNumber];
        
        
        self.allDisplay.text = [self.allDisplay.text stringByAppendingString:self.display.text];
    }else {
        
        double currentNumber = [self.display.text doubleValue];
        currentNumber = 0 -currentNumber;
        self.display.text = [NSString stringWithFormat:@"%g",currentNumber];
    
    }
    

}

@end
