//
//  ViewController.m
//  NumpadWithButtons
//
//  Created by Amitai Blickstein on 8/19/15.
//  Copyright (c) 2015 Amitai Blickstein, LLC. All rights reserved.
//

    //↓↓My standard lazy debug macro
#define DBLG NSLog(@"%@ reporting!", NSStringFromSelector(_cmd));
#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *number1TxF;
@property (weak, nonatomic) IBOutlet UITextField *number2TxF;
@property (weak, nonatomic) IBOutlet UILabel     *resultsLabel;
@property (weak, nonatomic) IBOutlet UILabel *operationSymbol;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /**
     *  Our calculator's buttons: +,-,x,÷,= and "+/-"
     */
    UIBarButtonItem *addButton      = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(prepareToAdd)];
    UIBarButtonItem *subtractButton = [[UIBarButtonItem alloc] initWithTitle:@"-" style:UIBarButtonItemStylePlain target:self action:@selector(prepareToSubtract)];
    UIBarButtonItem *multiplyButton = [[UIBarButtonItem alloc] initWithTitle:@"x" style:UIBarButtonItemStylePlain target:self action:@selector(prepareToMultiply)];
    UIBarButtonItem *divideButton   = [[UIBarButtonItem alloc] initWithTitle:@"÷" style:UIBarButtonItemStylePlain target:self action:@selector(prepareToDivide)];
    UIBarButtonItem *flipSign       = [[UIBarButtonItem alloc] initWithTitle:@"+/-" style:UIBarButtonItemStylePlain target:self action:@selector(flipSignOfActiveTextField)];
    UIBarButtonItem *equalsButton   = [[UIBarButtonItem alloc] initWithTitle:@"=" style:UIBarButtonItemStylePlain target:self action:@selector(calculateResults)];
    
    UIToolbar *calculatorOperationsBar = [UIToolbar new];
    [calculatorOperationsBar setItems:@[equalsButton,
                                        addButton,
                                        subtractButton,
                                        multiplyButton,
                                        divideButton,
                                        flipSign]];
    [calculatorOperationsBar sizeToFit];
    self.number1TxF.inputAccessoryView = calculatorOperationsBar;
    self.number2TxF.inputAccessoryView = calculatorOperationsBar;
}

    //The style for these lines of code chosen for clarity.
-(void)prepareToAdd      {self.operationSymbol.text = @"+";}
-(void)prepareToSubtract {self.operationSymbol.text = @"-";}
-(void)prepareToMultiply {self.operationSymbol.text = @"x";}
-(void)prepareToDivide   {self.operationSymbol.text = @"÷";}

-(void)flipSignOfActiveTextField {
    DBLG
    UITextField *activeTextfield;
    if ([self.number1TxF isFirstResponder]) {activeTextfield = self.number1TxF;}
    if ([self.number2TxF isFirstResponder]) {activeTextfield = self.number2TxF;}
    
    NSString *displayedNumber;
    displayedNumber = activeTextfield.text;
    
    if (displayedNumber.length) {
            //NSString → double → [do operation] → output double → NSNumber → NSString
        double numberValue     = [displayedNumber doubleValue];
        double flippedNumber   = numberValue * -1;
        NSString *flippedValue = [[NSNumber numberWithDouble:flippedNumber] stringValue];
            //↑ Also good: NSNumber literal notation @(), like so: [@(flippedNumber) stringValue]
        activeTextfield.text   = flippedValue;
    }
    
}

-(void)calculateResults {
    DBLG
        //Test that neither textfield is empty; you may prefer to
        //default an empty field as '0', or some other behavior.
    if (!(self.number1TxF.text.length *
          self.number2TxF.text.length)) {
        NSLog(@"Error, need two operands.");
        return;
    }
        //NSString → double → [do operation] → output double → NSNumber → NSString
    double numberValue1 = [self.number1TxF.text doubleValue];
    double numberValue2 = [self.number2TxF.text doubleValue];
    double resultValue = 0.0;
    if ([self.operationSymbol.text isEqualToString:@"+"]) {
        resultValue = numberValue1 + numberValue2;
    }
    if ([self.operationSymbol.text isEqualToString:@"-"]) {
        resultValue = numberValue1 - numberValue2;
    }
    if ([self.operationSymbol.text isEqualToString:@"x"]) {
        resultValue = numberValue1 * numberValue2;
    }
    if ([self.operationSymbol.text isEqualToString:@"÷"]) {
        resultValue = numberValue1 / numberValue2;
    }
    NSString *resultsString = [@(resultValue) stringValue];
    self.resultsLabel.text  = resultsString;
}

@end
