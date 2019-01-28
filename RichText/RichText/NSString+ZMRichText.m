//
//  NSString+ZMRichText.m
//  RichText
//
//  Created by xzm on 2019/1/28.
//  Copyright © 2019 xzm. All rights reserved.
//

#import "NSString+ZMRichText.h"

@implementation NSString (ZMRichText)

- (NSAttributedString *)zm_showEmoji
{
    static NSDictionary *emojiDic;
    static NSRegularExpression *regular = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //方括号需要加转义符
        regular = [[NSRegularExpression alloc]initWithPattern:@"\\[.*?\\]" options:NSRegularExpressionCaseInsensitive error:nil];
        emojiDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Faceexpression" ofType:@"plist"]];
    });
    
    NSMutableAttributedString *mAtt = [[NSMutableAttributedString alloc]initWithString:self];
    
    //获取匹配的结果
    NSArray *resultArray = [regular matchesInString:mAtt.string options:NSMatchingReportCompletion range:NSMakeRange(0, mAtt.string.length)];
    
    //从后往前遍历，这样才能正确替换表情
    [resultArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSTextCheckingResult *result, NSUInteger idx, BOOL * _Nonnull stop) {
        //替换表情
        NSString *emojiStr = [mAtt.string substringWithRange:result.range];
        UIImage *image = [UIImage imageNamed:[emojiDic objectForKey:emojiStr]];
        if (image) {
            NSTextAttachment *attch = [NSTextAttachment new];
            attch.image = image;
            attch.bounds = CGRectMake(0, -3, 56/3.f, 56/3.f);
            NSAttributedString *mSubStr = [NSAttributedString attributedStringWithAttachment:attch];
            [mAtt replaceCharactersInRange:result.range withAttributedString:mSubStr];
        }
    }];
    
    return mAtt;
}

- (NSAttributedString *)zm_tagHighlight
{
    return [self zm_tagHighlightWithColor:[UIColor blueColor]
                                  leftTag:@"<em>"
                                 rightTag:@"</em>"];
}

- (NSAttributedString *)zm_tagHighlightWithColor:(UIColor  *)color
                                         leftTag:(NSString *)leftTag
                                        rightTag:(NSString *)rightTag
{
    static NSRegularExpression *regular = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regular = [[NSRegularExpression alloc]initWithPattern:[NSString stringWithFormat:@"%@.*?%@",leftTag,rightTag] options:NSRegularExpressionCaseInsensitive error:nil];
    });
    
    NSMutableAttributedString *mAtt = [[NSMutableAttributedString alloc]initWithString:self];
    
    //获取匹配的结果
    NSArray *resultArray = [regular matchesInString:mAtt.string options:NSMatchingReportCompletion range:NSMakeRange(0, mAtt.string.length)];
    
    //从后往前遍历，这样才能正确替换字符串
    [resultArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSTextCheckingResult *result, NSUInteger idx, BOOL * _Nonnull stop) {
        //拿到目标字符串
        NSString *highStr = [mAtt.string substringWithRange:NSMakeRange(result.range.location + leftTag.length, result.range.length - leftTag.length - rightTag.length)];
        //用高亮字符串替换标签字符串
        NSAttributedString *mSubStr = [[NSAttributedString alloc]initWithString:highStr attributes:@{NSForegroundColorAttributeName:color}];
        [mAtt replaceCharactersInRange:result.range withAttributedString:mSubStr];
    }];
    
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

- (NSAttributedString *)zm_highlight:(NSString *)hString color:(UIColor *)hColor
{
    NSMutableAttributedString *mAtt = [[NSMutableAttributedString alloc]initWithString:self];
    [mAtt addAttribute:NSForegroundColorAttributeName value:hColor range:[self rangeOfString:hString]];
    return mAtt;
}

@end
