//
//  SCustomKeyboardView.m
//  Pods
//
//  Created by hey on 2017/11/29.
//

#import "SCustomKeyboardView.h"
#import "UIImage+STint.h"

#define KEYBOARD_HEIGHT 216

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@interface SCustomKeyboardView ()

@property (nonatomic, strong) NSMutableString *string; //the keyboard related string

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) UITextField *temTextfield;

/**
 确定按钮背景色，默认为蓝色
 */
@property (nonatomic, strong) UIColor *sureButtonBgColor;



@end

@implementation SCustomKeyboardView

@synthesize titleArray;

-(instancetype)initSCustomKeyboardWithTextfile:(UITextField *)textfield withType:(SCustomKeyboardType)keyboardType
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, SCREEN_SIZE.height - KEYBOARD_HEIGHT, SCREEN_SIZE.width, KEYBOARD_HEIGHT);
        self.string = [NSMutableString string];
        self.backgroundColor = [UIColor lightTextColor];
        _temTextfield = textfield;
        self.sureButtonBgColor = [UIColor colorWithRed:0.02 green:0.65 blue:0.97 alpha:1.00];
        [self initKeyboardDataSourceWith:keyboardType with:YES];
        //initialize the keyboard
        [self createButtons];
    }
    return self;
}

-(instancetype)initSCustomKeyboardWithTextfile:(UITextField *)textfield withType:(SCustomKeyboardType)keyboardType withDisorder:(BOOL)disorder
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, SCREEN_SIZE.height - KEYBOARD_HEIGHT, SCREEN_SIZE.width, KEYBOARD_HEIGHT);
        self.string = [NSMutableString string];
        self.backgroundColor = [UIColor lightTextColor];
        _temTextfield = textfield;
        
        [self initKeyboardDataSourceWith:keyboardType with:disorder];
        //initialize the keyboard
        [self createButtons];
    }
    return self;
}

-(void)initKeyboardDataSourceWith:(SCustomKeyboardType)type with:(BOOL)disorder
{
    NSMutableArray *mutArray = [[NSMutableArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    //无序
    if (disorder) {
        mutArray = [self getRandomArrFrome:[mutArray mutableCopy]];
    }
    
    if (type == SCustomKeyboardTypeNumber) {
        [mutArray addObjectsFromArray:@[@"", @"0", @"down"]];
    }
    else if (type == SCustomKeyboardTypeDecimalPad)
    {
        [mutArray addObjectsFromArray:@[@".", @"0", @"down"]];
    }
    else if (type == SCustomKeyboardTypeIDCard)
    {
        [mutArray addObjectsFromArray:@[@"X", @"0", @"down"]];
    }
    else
    {
        [mutArray addObjectsFromArray:@[@".", @"0", @"down"]];
    }
    self.titleArray = [mutArray mutableCopy];

}

-(NSMutableArray*)getRandomArrFrome:(NSArray*)arr
{
    NSMutableArray *newArr = [NSMutableArray new];
    while (newArr.count != arr.count) {
        //生成随机数
        int x =arc4random() % arr.count;
        id obj = arr[x];
        if (![newArr containsObject:obj]) {
            [newArr addObject:obj];
        }
    }
    return newArr;
}

//add button to the defined keyboard view
- (UIButton *)addButtonWithTitle:(NSString *)title frame:(CGRect)frame_rect image:(UIImage *)normal_image highImage:(UIImage *)high_image
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame_rect];
//    button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundImage:normal_image forState:UIControlStateNormal];
    [button setBackgroundImage:high_image forState:UIControlStateHighlighted];
    
    return button;
}

//create all the buttons
- (void)createButtons
{
    
    //design the keyboard
    int index = 0;
    //4行3列
    float button_width = (SCREEN_SIZE.width - 100) / 3;
    float button_height = KEYBOARD_HEIGHT / 4;
    float padding = 0;
    //创建按钮
    for(int i = 0; i < 4; i++)
    {
        for(int j = 0; j < 3; j++)
        {
            float x = j*(button_width + padding);
            float y = i*(button_height + padding);
            
            UIButton *button = [self addButtonWithTitle:titleArray[index] frame:CGRectMake(x, y, button_width, button_height) image:nil highImage:[UIImage createImageWithColor:[UIColor lightGrayColor]]];
            if ([titleArray[index] isEqualToString:@"down"] ) {
                [button setImage:[UIImage getRdImageResourceBundleWithName:@"keboard"] forState:UIControlStateNormal];
                [button setTitle:@"" forState:UIControlStateNormal];
                [button setImageEdgeInsets:UIEdgeInsetsMake((button_height-32)/2, (button_width-32)/2, (button_height-32)/2, (button_width-32)/2)];
                [button addTarget:self action:@selector(cancelEdit:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            [button setBackgroundColor:[UIColor whiteColor]];
            [self addSubview:button];
            
            button.layer.borderColor = [UIColor lightGrayColor].CGColor;
            button.layer.borderWidth = 0.5;
            button.layer.masksToBounds = YES;
            
            //increase index
            index++;
        }
    }
    //删除按钮
    UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(button_width*3, 0, 100, KEYBOARD_HEIGHT/2)];
    [deleteButton setImage :[UIImage getRdImageResourceBundleWithName:@"back"] forState:UIControlStateNormal];
    [deleteButton setImageEdgeInsets:UIEdgeInsetsMake((KEYBOARD_HEIGHT/2-32)/2, (100-32)/2, (KEYBOARD_HEIGHT/2-32)/2, (100-32)/2)];
    [deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteButton];
    //确定按钮
    self.sureButton = [[UIButton alloc] initWithFrame:CGRectMake(button_width*3, KEYBOARD_HEIGHT/2, 100, KEYBOARD_HEIGHT/2)];
    [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.sureButton setBackgroundColor:self.sureButtonBgColor];
    [self.sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.sureButton];

}

//button callback
- (void)onClick:(UIButton *)button
{
    //respond to local button events
    [self.string appendString:button.currentTitle];
    _temTextfield.text = self.string;
    //call the delegate, first make sure it can respond to selector, then do the delegate method
    if ([self.delegate respondsToSelector:@selector(keyboard:withTextfield:withFieldString:)])
    {
        [self.delegate keyboard:self withTextfield:_temTextfield withFieldString:self.string];

    }
}


-(void)deleteButtonAction:(id)sender
{
    if (self.string.length > 0) {
        [self.string deleteCharactersInRange:NSMakeRange(self.string.length-1, 1)];
        if ([self.delegate respondsToSelector:@selector(keyboard:withTextfield:withFieldString:)])
        {
            _temTextfield.text = self.string;
            [self.delegate keyboard:self withTextfield:_temTextfield withFieldString:self.string];
            
        }
    }
}

-(void)cancelEdit:(id)sender
{
    [_temTextfield resignFirstResponder];
}

-(void)sureButtonAction:(id)sender
{
//    [self endEditing:YES];
    if (_delegate && [_delegate respondsToSelector:@selector(keyboard:doneEditWithTextField:withResult:)]) {
        [_delegate keyboard:self doneEditWithTextField:_temTextfield withResult:self.string];
    }
    [_temTextfield resignFirstResponder];
}

-(void)setSureButtonBackgroundColor:(UIColor *)backgroundColor
{
    [self.sureButton setBackgroundColor:backgroundColor];
}

@end
