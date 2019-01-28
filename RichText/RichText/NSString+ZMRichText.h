//
//  NSString+ZMRichText.h
//  RichText
//
//  Created by xzm on 2019/1/28.
//  Copyright © 2019 xzm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (ZMRichText)

/**
 显示以”[]“标识的表情
 */
- (NSAttributedString *)zm_showEmoji;


/**
 将带有标签的字符串转成高亮
 默认高亮为蓝色
 默认左标签：@"<em>"，右标签：@"</em>"
 */
- (NSAttributedString *)zm_tagHighlight;


/**
 将带有标签的字符串转成高亮
 
 @param color 高亮色
 @param leftTag 左标签
 @param rightTag 右标签
 @return 高亮属性字符串
 */
- (NSAttributedString *)zm_tagHighlightWithColor:(UIColor  *)color
                                         leftTag:(NSString *)leftTag
                                        rightTag:(NSString *)rightTag;


/**
 删除标签
 默认左标签：@"<em>"，右标签：@"</em>"
 */
- (NSString *)zm_deleteTag;


/**
 删除标签
 
 @param leftTag 左标签
 @param rightTag 右标签
 @return 字符串
 */
- (NSString *)zm_deleteTagWithLeft:(NSString *)leftTag right:(NSString *)rightTag;


/**
 高亮指定字符串

 @param hString 指定字符串
 @param hColor 高亮色
 @return 属性字符串
 */
- (NSAttributedString *)zm_highlight:(NSString *)hString color:(UIColor *)hColor;

@end


