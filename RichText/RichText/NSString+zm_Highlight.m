//
//  NSString+zm_Highlight.m
//  RichText
//
//  Created by xzm on 2019/1/25.
//  Copyright © 2019 xzm. All rights reserved.
//

#import "NSString+zm_Highlight.h"

@implementation NSString (zm_Highlight)

- (NSAttributedString *)zm_highlight
{
    return [self zm_highlightWithColor:[UIColor blueColor]
                               leftTag:@"<em>"
                              rightTag:@"</em>"];
}


- (NSAttributedString *)zm_highlightWithColor:(UIColor  *)color
                                      leftTag:(NSString *)leftTag
                                     rightTag:(NSString *)rightTag
{
    static NSRegularExpression *regular = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regular = [[NSRegularExpression alloc]initWithPattern:[NSString stringWithFormat:@"%@.*?%@",leftTag,rightTag] options:NSRegularExpressionCaseInsensitive error:nil];
    });
    
    NSMutableAttributedString *mAtt = [[NSMutableAttributedString alloc]initWithString:self];
    
    //查找标签字符串
    NSTextCheckingResult *result = [regular firstMatchInString:mAtt.string options:NSMatchingReportCompletion range:NSMakeRange(0, mAtt.string.length)];
    
    //如果有结果，则继续循环查找
    while (result) {
        NSString *highStr = [mAtt.string substringWithRange:NSMakeRange(result.range.location + leftTag.length, result.range.length - leftTag.length - rightTag.length)];
        
        //用高亮字符串替换标签字符串
        NSMutableAttributedString *mSubStr = [[NSMutableAttributedString alloc]initWithString:highStr attributes:@{NSForegroundColorAttributeName:color}];
        [mAtt replaceCharactersInRange:result.range withAttributedString:mSubStr];
        
        result = [regular firstMatchInString:mAtt.string options:NSMatchingReportCompletion range:NSMakeRange(0, mAtt.string.length)];
    }
    
    return mAtt;
}


- (NSString *)zm_deleteTag
{
    return [self zm_deleteTagWithLeft:@"<em>" right:@"</em>"];
}

- (NSString *)zm_deleteTagWithLeft:(NSString *)leftTag right:(NSString *)rightTag
{
    NSRegularExpression *regu = [[NSRegularExpression alloc]initWithPattern:[NSString stringWithFormat:@"%@|%@",leftTag,rightTag] options:NSRegularExpressionCaseInsensitive error:nil];

    return [regu stringByReplacingMatchesInString:self options:NSMatchingReportCompletion range:NSMakeRange(0, self.length) withTemplate:@""];
}

@end
