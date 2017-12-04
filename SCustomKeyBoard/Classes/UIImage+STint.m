//
//  UIImage+STint.m
//  Pods
//
//  Created by hey on 2017/11/29.
//

#import "UIImage+STint.h"
#import "SCustomKeyboardView.h"

@implementation UIImage (STint)

-(UIImage *) imageWithTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

+ (UIImage*)createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)getRDImageResourceBundleWithPath:(NSString *)path ofType:(NSString *)type inBundle:(NSBundle *)bundle {
    return [UIImage imageWithContentsOfFile:[bundle pathForResource:path ofType:type]];
}

+ (UIImage *)getRdImageResourceBundleWithName:(NSString *)name
{
    NSURL *url = [[NSBundle bundleForClass:[SCustomKeyboardView class]] URLForResource:@"SCustomKeyBoard" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    
    NSString *path = [imageBundle pathForResource:name ofType:@"png"];
    
    return [UIImage imageWithContentsOfFile:path];
    
//    return [self getRdImageResourceBundleWithName:name inBundle:[NSBundle bundleForClass:[NumberKeyboardView class]]];
   
}
+ (UIImage *)getRdImageResourceBundleWithName:(NSString *)name inBundle:(NSBundle *)bundle
{
    float scale = [UIScreen mainScreen].scale;
    NSString *imgName;
    if (scale > 2) {
        imgName = [NSString stringWithFormat:@"SCustomKeyBoard.bundle/%@@3x",name];
    }
    else
    {
        imgName = [NSString stringWithFormat:@"SCustomKeyBoard.bundle/%@@2x",name];
    }
    
    UIImage *image = [UIImage getRDImageResourceBundleWithPath:imgName ofType:@"png" inBundle:bundle];
    //如果只有一倍图存在
    if (!image) {
        image = [UIImage getRDImageResourceBundleWithPath:[NSString stringWithFormat:@"SCustomKeyBoard.bundle/%@",name] ofType:@"png" inBundle:bundle];
    }
    return image;
}

@end
