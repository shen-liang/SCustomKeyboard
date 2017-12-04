//
//  RDViewController.m
//  SCustomKeyBoard
//
//  Created by shenliang on 11/28/2017.
//  Copyright (c) 2017 shenliang. All rights reserved.
//

#import "RDViewController.h"
#import <SCustomKeyBoard/SCustomKeyboardView.h>

//#import <NumberKeyboardView.h>

@interface RDViewController ()<SCustomKeyboardViewDelegate>

@end

@implementation RDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    SCustomKeyboardView *numberView = [[SCustomKeyboardView alloc] initSCustomKeyboardWithTextfile:_numberTextField withType:SCustomKeyboardTypeNumber];
    numberView.delegate = self;
//    [numberView setSureButtonBackgroundColor:[UIColor redColor]];
    _numberTextField.inputView = numberView;
    
    SCustomKeyboardView *decimalNumberView = [[SCustomKeyboardView alloc] initSCustomKeyboardWithTextfile:_pointNumberTextfiled withType:SCustomKeyboardTypeDecimalPad];
    decimalNumberView.delegate = self;
    _pointNumberTextfiled.inputView = decimalNumberView;
    
    SCustomKeyboardView *idcardView = [[SCustomKeyboardView alloc] initSCustomKeyboardWithTextfile:_idcardTextfiled withType:SCustomKeyboardTypeIDCard];
    idcardView.delegate = self;
    _idcardTextfiled.inputView = idcardView;
    
}


#pragma mark - define method: callbacks

-(void)keyboard:(SCustomKeyboardView *)keyboard withTextfield:(UITextField *)textfield withFieldString:(NSMutableString *)string
{
    if (textfield == _idcardTextfiled) {
        NSLog(@"idcard = %@",string);
    }
    else if (textfield == _pointNumberTextfiled)
    {
        NSLog(@"point text = %@",string);
    }
    else if (textfield == _numberTextField)
    {
        NSLog(@"number text = %@",string);
    }
}


/**
 结束编辑，点击确认按钮

 @param keyboard <#keyboard description#>
 @param textfield <#textfield description#>
 @param result <#result description#>
 */
-(void)keyboard:(SCustomKeyboardView *)keyboard doneEditWithTextField:(UITextField *)textfield withResult:(NSString *)result
{
    NSLog(@"resut = %@",result);
}

@end
