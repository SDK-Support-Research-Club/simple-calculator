//
//  ViewController.m
//  NumpadWithButtons
//
//  Created by Amitai Blickstein on 8/19/15.
//  Copyright (c) 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import "ViewController.h"
#define DBLG NSLog(@"%@ reporting!", NSStringFromSelector(_cmd));


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
     *  Our calculator's buttons: +,-,*,/,= and "+/-"
     */
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(prepareToAdd)];
    UIBarButtonItem *subtractButton = [[UIBarButtonItem alloc] initWithTitle:@"-" style:UIBarButtonItemStylePlain target:self action:@selector(prepareToSubtract)];
    UIBarButtonItem *multiplyButton = [[UIBarButtonItem alloc] initWithTitle:@"*" style:UIBarButtonItemStylePlain target:self action:@selector(prepareToMultiply)];
    UIBarButtonItem *divideButton = [[UIBarButtonItem alloc] initWithTitle:@"/" style:UIBarButtonItemStylePlain target:self action:@selector(prepareToDivide)];
    UIBarButtonItem *flipSign = [[UIBarButtonItem alloc] initWithTitle:@"+/-" style:UIBarButtonItemStylePlain target:self action:@selector(flipSignOfActiveTextField)];
    UIBarButtonItem *equalsButton = [[UIBarButtonItem alloc] initWithTitle:@"=" style:UIBarButtonItemStylePlain target:self action:@selector(calculateResults)];
    
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

    //Style for these lines chosen for clarity.
-(void)prepareToAdd      {self.operationSymbol.text = @"+";}
-(void)prepareToSubtract {self.operationSymbol.text = @"-";}
-(void)prepareToMultiply {self.operationSymbol.text = @"*";}
-(void)prepareToDivide   {self.operationSymbol.text = @"/";}

    //This code has been elaborated for what I call "plain-English clarity".
-(void)flipSignOfActiveTextField {
    DBLG
    UITextField *activeTextfield;
    if ([self.number1TxF isFirstResponder]) {activeTextfield = self.number1TxF;}
    if ([self.number2TxF isFirstResponder]) {activeTextfield = self.number2TxF;}
    
    NSString *displayedValue;
    displayedValue = activeTextfield.text;
    
    if (displayedValue.length) {
            //Plain-English 'setup'.
        NSString *flippedValue;
        
        BOOL valueIsNegative;
        if ([displayedValue hasPrefix:@"-"]) {valueIsNegative = YES;}
        else                                 {valueIsNegative = NO ;}
        BOOL valueIsPositive = !valueIsNegative;
        
            //commence 'Plain-English'
        if (valueIsNegative) {
            flippedValue = [displayedValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
        }
        if (valueIsPositive) {
            flippedValue = [NSString stringWithFormat:@"-%@", displayedValue];
        }
        
        activeTextfield.text = flippedValue;
    }
}

-(void)calculateResults {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
