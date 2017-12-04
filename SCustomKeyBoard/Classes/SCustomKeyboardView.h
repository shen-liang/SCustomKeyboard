//
//  SCustomKeyboardView.h
//  Pods
//
//  Created by hey on 2017/11/29.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SCustomKeyboardType)
{
    /*
     纯数字键盘，不含小数点
     */
    SCustomKeyboardTypeNumber = 0x0001,
    /*
     纯数字键盘，包含小数点
     */
    SCustomKeyboardTypeDecimalPad = 0x0002,
    /*
     身份证键盘
     */
    SCustomKeyboardTypeIDCard = 0x0003,
};

@class SCustomKeyboardView;

//the defined numberPad delegate
@protocol SCustomKeyboardViewDelegate<NSObject>

@optional
// delegate function to press keyboard button
- (void)keyboard:(SCustomKeyboardView *)keyboard withTextfield:(UITextField *)textfield withFieldString:(NSMutableString *)string;

- (void)keyboard:(SCustomKeyboardView *)keyboard doneEditWithTextField:(UITextField *)textfield withResult:(NSString *)result;

@end


// numberPad view
@interface SCustomKeyboardView : UIView

/**
 构造1

 @param textfield 输入框
 @param keyboardType 键盘类型
 @return 自定义键盘
 */
-(instancetype)initSCustomKeyboardWithTextfile:(UITextField *)textfield withType:(SCustomKeyboardType)keyboardType;

/**
 构造2

 @param textfield 输入框
 @param keyboardType 键盘类型
 @param disorder 是否需要无序的按键布局
 @return 自定义键盘
 */
-(instancetype)initSCustomKeyboardWithTextfile:(UITextField *)textfield withType:(SCustomKeyboardType)keyboardType withDisorder:(BOOL)disorder;

-(void)setSureButtonBackgroundColor:(UIColor *)color;


@property (nonatomic, assign) id<SCustomKeyboardViewDelegate> delegate;

@property (nonatomic, strong) UIButton *sureButton;

@property (nonatomic, assign) SCustomKeyboardType *keyboardType;

@end
