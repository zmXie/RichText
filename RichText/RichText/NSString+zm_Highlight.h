//
//  NSString+zm_Highlight.h
//  RichText
//
//  Created by xzm on 2019/1/25.
//  Copyright © 2019 xzm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 将带有标签的字符串转成高亮
 */
@interface NSString (zm_Highlight)


/**
 将带有标签的字符串转成高亮
 默认高亮为蓝色
 默认左标签：@"<em>"，右标签：@"</em>"
 */
- (NSAttributedString *)zm_highlight;


/**
 将带有标签的字符串转成高亮

 @param color 高亮色
 @param leftTag 左标签
 @param rightTag 右标签
 @return 高亮属性字符串
 */
- (NSAttributedString *)zm_highlightWithColor:(UIColor  *)color
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


@end

