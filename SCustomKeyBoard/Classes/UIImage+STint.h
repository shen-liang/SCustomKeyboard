//
//  UIImage+STint.h
//  Pods
//
//  Created by hey on 2017/11/29.
//

#import <UIKit/UIKit.h>

@interface UIImage (STint)

- (UIImage *)imageWithTintColor:(UIColor *)tintColor;

- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;

+ (UIImage*)createImageWithColor:(UIColor*) color;

/**
 *  默认加载资源图片
 *
 *  @param name <#name description#>
 *
 *  @return <#return value description#>
 */
+ (UIImage *)getRdImageResourceBundleWithName:(NSString *)name;

@end
