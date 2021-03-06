//
//  SJAttributeWorker.m
//  SJAttributeWorker
//
//  Created by 畅三江 on 2017/11/12.
//  Copyright © 2017年 畅三江. All rights reserved.
//

#import "SJAttributeWorker.h"


@interface NSString (SJAdd)
@end

@implementation NSString (SJAdd)
- (NSString *)string {
    return self;
}
@end


@interface SJAttributeWorker ()

@property (nonatomic, strong, readonly) NSMutableAttributedString *attrM;
@property (nonatomic, strong, readonly) NSMutableParagraphStyle *style;
@property (nonatomic, strong, readonly) NSMutableDictionary<NSValue *, NSParagraphStyle *> *localParagraphStyleDictM;

@property (nonatomic, strong, readwrite) UIFont *r_nextFont;
@property (nonatomic, strong, readwrite) NSNumber *r_nextExpansion;
@property (nonatomic, strong, readwrite) UIColor *r_nextFontColor;
@property (nonatomic, strong, readwrite) NSShadow *r_nextShadow;
@property (nonatomic, strong, readwrite) NSNumber *r_nextUnderline;
@property (nonatomic, strong, readwrite) UIColor *r_nextUnderlineColor;
@property (nonatomic, strong, readwrite) NSNumber *r_nextStrikethough;
@property (nonatomic, strong, readwrite) UIColor *r_nextStrikethoughColor;
@property (nonatomic, strong, readwrite) UIColor *r_nextBackgroundColor;
@property (nonatomic, strong, readwrite) NSNumber *r_nextLetterSpacing;
@property (nonatomic, strong, readwrite) NSMutableDictionary<NSString *, NSNumber *> *r_paragraphStylePropertiesM;
@property (nonatomic, strong, readwrite) NSNumber *r_nextStrokeBorder;
@property (nonatomic, strong, readwrite) UIColor *r_nextStrokeColor;
@property (nonatomic, assign, readwrite) BOOL r_nextLetterpress;
@property (nonatomic, assign, readwrite) BOOL r_nextLink;
@property (nonatomic, strong, readwrite) NSNumber *r_nextOffset;
@property (nonatomic, strong, readwrite) NSNumber *r_nextObliqueness;

@end

@implementation SJAttributeWorker

@synthesize attrM = _attrM;
@synthesize style = _style;
@synthesize localParagraphStyleDictM = _localParagraphStyleDictM;

- (instancetype)init {
    self = [super init];
    if ( !self ) return nil;
    [self prepareWork];
    return self;
}

- (void)prepareWork {
    _attrM = [NSMutableAttributedString new];
}

- (NSAttributedString *)endTask {
    [self _finishingOperation];
    return _attrM;
}

#pragma mark -
- (void)_finishingOperation {
    if ( _style ) self.paragraphStyle(_style);
    if ( _localParagraphStyleDictM ) {
        [_localParagraphStyleDictM enumerateKeysAndObjectsUsingBlock:^(NSValue * _Nonnull key, NSParagraphStyle * _Nonnull obj, BOOL * _Nonnull stop) {
            NSRange range = [key rangeValue];
            [_attrM addAttribute:NSParagraphStyleAttributeName value:obj range:range];
        }];
    }
}

- (void)_pauseTask {
    [self _finishingOperation];
}

#pragma mark -
- (SJAttributeWorker *(^)(UIFont *font))font {
    return ^ SJAttributeWorker *(UIFont *font) {
        [_attrM addAttribute:NSFontAttributeName value:font range:_rangeAll(_attrM)];
        return self;
    };
}

- (SJAttributeWorker *(^)(float))expansion {
    return ^ SJAttributeWorker *(float expansion) {
        [_attrM addAttribute:NSExpansionAttributeName value:@(expansion) range:_rangeAll(_attrM)];
        return self;
    };
}

- (SJAttributeWorker *(^)(UIColor *))fontColor {
    return ^ SJAttributeWorker *(UIColor *fontColor) {
        [_attrM addAttribute:NSForegroundColorAttributeName value:fontColor range:_rangeAll(_attrM)];
        return self;
    };
}

- (SJAttributeWorker *(^)(NSShadow *))shadow {
    return ^ SJAttributeWorker *(NSShadow *shadow) {
        [_attrM addAttribute:NSShadowAttributeName value:shadow range:_rangeAll(_attrM)];
        return self;
    };
}

- (SJAttributeWorker *(^)(UIColor *))backgroundColor {
    return ^ SJAttributeWorker *(UIColor *color) {
        [_attrM addAttribute:NSBackgroundColorAttributeName value:color range:_rangeAll(_attrM)];
        return self;
    };
}

- (SJAttributeWorker *(^)(float))lineSpacing {
    return ^ SJAttributeWorker *(float lineSpacing) {
        self.style.lineSpacing = lineSpacing;
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(float))paragraphSpacing {
    return ^ SJAttributeWorker *(float paragraphSpacing) {
        self.style.paragraphSpacing = paragraphSpacing;
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(float))paragraphSpacingBefore {
    return ^ SJAttributeWorker *(float paragraphSpacingBefore) {
        self.style.paragraphSpacingBefore = paragraphSpacingBefore;
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(float))firstLineHeadIndent {
    return ^ SJAttributeWorker *(float firstLineHeadIndent) {
        self.style.firstLineHeadIndent = firstLineHeadIndent;
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(float))headIndent {
    return ^ SJAttributeWorker *(float headIndent) {
        self.style.headIndent = headIndent;
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(float))tailIndent {
    return ^ SJAttributeWorker *(float tailIndent) {
        self.style.tailIndent = tailIndent;
        return self;
    };
}

- (SJAttributeWorker *(^)(float))letterSpacing {
    return ^ SJAttributeWorker *(float spacing) {
        [_attrM addAttribute:NSKernAttributeName value:@(spacing) range:_rangeAll(_attrM)];
        return self;
    };
}

- (SJAttributeWorker *(^)(NSTextAlignment))alignment {
    return ^ SJAttributeWorker *(NSTextAlignment alignment) {
        self.style.alignment = alignment;
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(NSLineBreakMode))lineBreakMode {
    return ^ SJAttributeWorker *(NSLineBreakMode mode) {
        self.style.lineBreakMode = mode;
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(NSUnderlineStyle, UIColor * _Nonnull))underline {
    return ^ SJAttributeWorker *(NSUnderlineStyle style, UIColor *color) {
        [_attrM addAttribute:NSUnderlineStyleAttributeName value:@(style) range:_rangeAll(_attrM)];
        [_attrM addAttribute:NSUnderlineColorAttributeName value:color range:_rangeAll(_attrM)];
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(NSUnderlineStyle, UIColor * _Nonnull))strikethrough {
    return ^ SJAttributeWorker *(NSUnderlineStyle style, UIColor *color) {
        [_attrM addAttribute:NSStrikethroughStyleAttributeName value:@(style) range:_rangeAll(_attrM)];
        [_attrM addAttribute:NSStrikethroughColorAttributeName value:color range:_rangeAll(_attrM)];
        return self;
    };
}

- (SJAttributeWorker *(^)(float, UIColor *))stroke {
    return ^ SJAttributeWorker *(float border, UIColor *color) {
        [_attrM addAttribute:NSStrokeWidthAttributeName value:@(border) range:_rangeAll(_attrM)];
        [_attrM addAttribute:NSStrokeColorAttributeName value:color range:_rangeAll(_attrM)];
        return self;
    };
}

- (SJAttributeWorker *(^)(void))letterpress {
    return ^ SJAttributeWorker *(void) {
        [_attrM addAttribute:NSTextEffectAttributeName value:NSTextEffectLetterpressStyle range:_rangeAll(_attrM)];
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(void))link {
    return ^ SJAttributeWorker *(void) {
        [_attrM addAttribute:NSLinkAttributeName value:@(1) range:_rangeAll(_attrM)];
        return self;
    };
}

- (SJAttributeWorker *(^)(NSParagraphStyle *))paragraphStyle {
    return ^ SJAttributeWorker *(NSParagraphStyle *style) {
        [_attrM addAttribute:NSParagraphStyleAttributeName value:style range:_rangeAll(_attrM)];
        return self;
    };
}

- (SJAttributeWorker *(^)(float))obliqueness {
    return ^ SJAttributeWorker *(float obliqueness) {
        [_attrM addAttribute:NSObliquenessAttributeName value:@(obliqueness) range:_rangeAll(_attrM)];
        return self;
    };
}

#pragma mark -

- (SJAttributeWorker * _Nonnull (^)(NSRange, void (^ _Nonnull)(SJAttributeWorker * _Nonnull)))rangeEdit {
    return ^ SJAttributeWorker *(NSRange range, void(^task)(SJAttributeWorker *rangeWorker)) {
        task(self);
        self.range(range);
        return self;
    };
}

- (void (^)(NSRange))range {
    return ^(NSRange range) {
        if ( _r_nextFont ) {
            [_attrM addAttribute:NSFontAttributeName value:_r_nextFont range:range];
            _r_nextFont = nil;
        }
        if ( _r_nextExpansion ) {
            [_attrM addAttribute:NSExpansionAttributeName value:_r_nextExpansion range:range];
            _r_nextExpansion = nil;
        }
        if ( _r_nextFontColor ) {
            [_attrM addAttribute:NSForegroundColorAttributeName value:_r_nextFontColor range:range];
            _r_nextFontColor = nil;
        }
        if ( _r_nextUnderline ) {
            [_attrM addAttribute:NSUnderlineStyleAttributeName value:_r_nextUnderline range:range];
            _r_nextUnderline = nil;
        }
        if ( _r_nextUnderlineColor ) {
            [_attrM addAttribute:NSUnderlineColorAttributeName value:_r_nextUnderlineColor range:range];
            _r_nextUnderlineColor = nil;
        }
        if ( _r_nextBackgroundColor ) {
            [_attrM addAttribute:NSBackgroundColorAttributeName value:_r_nextBackgroundColor range:range];
            _r_nextBackgroundColor = nil;
        }
        if ( _r_nextLetterSpacing ) {
            [_attrM addAttribute:NSKernAttributeName value:_r_nextLetterSpacing range:range];
            _r_nextLetterSpacing = nil;
        }
        if ( _r_nextStrikethough ) {
            [_attrM addAttribute:NSStrikethroughStyleAttributeName value:_r_nextStrikethough range:range];
            _r_nextStrikethough = nil;
        }
        if ( _r_nextStrikethoughColor ) {
            [_attrM addAttribute:NSStrikethroughColorAttributeName value:_r_nextStrikethoughColor range:range];
            _r_nextStrikethoughColor = nil;
        }
        if ( _r_nextStrokeBorder ) {
            [_attrM addAttribute:NSStrokeWidthAttributeName value:_r_nextStrokeBorder range:range];
            _r_nextStrokeBorder = nil;
        }
        if ( _r_nextStrokeColor ) {
            [_attrM addAttribute:NSStrokeColorAttributeName value:_r_nextStrokeColor range:range];
            _r_nextStrokeColor = nil;
        }
        if ( _r_nextLetterpress ) {
            [_attrM addAttribute:NSTextEffectAttributeName value:NSTextEffectLetterpressStyle range:range];
            _r_nextLetterpress = NO;
        }
        if ( _r_paragraphStylePropertiesM ) {
            NSMutableParagraphStyle *styleM = [NSMutableParagraphStyle new];
            [styleM setValuesForKeysWithDictionary:_r_paragraphStylePropertiesM];
            [self.localParagraphStyleDictM setObject:styleM forKey:[NSValue valueWithRange:range]];
            _r_paragraphStylePropertiesM = nil;
        }
        if ( _r_nextLink ) {
            [_attrM addAttribute:NSLinkAttributeName value:@(1) range:range];
            _r_nextLink = NO;
        }
        if ( _r_nextOffset ) {
            [_attrM addAttribute:NSBaselineOffsetAttributeName value:_r_nextOffset range:range];
            _r_nextOffset = nil;
        }
        if ( _r_nextObliqueness ) {
            [_attrM addAttribute:NSObliquenessAttributeName value:_r_nextObliqueness range:range];
            _r_nextObliqueness = nil;
        }
        if ( _r_nextShadow ) {
            [_attrM addAttribute:NSShadowAttributeName value:_r_nextShadow range:range];
            _r_nextShadow = nil;
        }
    };
}

- (SJAttributeWorker *(^)(UIFont *font))nextFont {
    return ^ SJAttributeWorker *(UIFont *font) {
        _r_nextFont = font;
        return self;
    };
}

- (SJAttributeWorker *(^)(float))nextExpansion {
    return ^ SJAttributeWorker *(float expansion) {
        _r_nextExpansion = @(expansion);
        return self;
    };
}

- (SJAttributeWorker *(^)(UIColor *color))nextFontColor {
    return ^ SJAttributeWorker *(UIColor *fontColor) {
        _r_nextFontColor = fontColor;
        return self;
    };
}

- (SJAttributeWorker *(^)(NSShadow *))nextShadow {
    return ^ SJAttributeWorker *(NSShadow *nextShadow) {
        _r_nextShadow = nextShadow;
        return self;
    };
}

- (SJAttributeWorker *(^)(UIColor *))nextBackgroundColor {
    return ^ SJAttributeWorker *(UIColor *color) {
        _r_nextBackgroundColor = color;
        return self;
    };
}

- (SJAttributeWorker *(^)(float))nextLetterSpacing {
    return ^ SJAttributeWorker *(float spacing) {
        _r_nextLetterSpacing = @(spacing);
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(float))nextLineSpacing {
    return ^ SJAttributeWorker *(float nextLineSpacing) {
        self.r_paragraphStylePropertiesM[@"lineSpacing"] = @(nextLineSpacing);
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(float))nextParagraphSpacing {
    return ^ SJAttributeWorker *(float nextParagraphSpacing) {
        self.r_paragraphStylePropertiesM[@"paragraphSpacing"] = @(nextParagraphSpacing);
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(float))nextParagraphSpacingBefore {
    return ^ SJAttributeWorker *(float nextParagraphSpacingBefore) {
        self.r_paragraphStylePropertiesM[@"paragraphSpacingBefore"] = @(nextParagraphSpacingBefore);
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(float))nextFirstLineHeadIndent {
    return ^ SJAttributeWorker *(float nextFirstLineHeadIndent) {
        self.r_paragraphStylePropertiesM[@"firstLineHeadIndent"] = @(nextFirstLineHeadIndent);
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(float))nextHeadIndent {
    return ^ SJAttributeWorker *(float nextHeadIndent) {
        self.r_paragraphStylePropertiesM[@"headIndent"] = @(nextHeadIndent);
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(float))nextTailIndent {
    return ^ SJAttributeWorker *(float nextTailIndent) {
        self.r_paragraphStylePropertiesM[@"tailIndent"] = @(nextTailIndent);
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(NSTextAlignment))nextAlignment {
    return ^ SJAttributeWorker *(NSTextAlignment nextAlignment) {
        self.r_paragraphStylePropertiesM[@"alignment"] = @(nextAlignment);
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(NSUnderlineStyle, UIColor * _Nonnull))nextUnderline {
    return ^ SJAttributeWorker *(NSUnderlineStyle style, UIColor *color) {
        _r_nextUnderline = @(style);
        _r_nextUnderlineColor = color;
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(NSUnderlineStyle, UIColor * _Nonnull))nextStrikethough {
    return ^ SJAttributeWorker *(NSUnderlineStyle style, UIColor *color) {
        _r_nextStrikethough = @(style);
        _r_nextStrikethoughColor = color;
        return self;
    };
}

- (SJAttributeWorker *(^)(float, UIColor *))nextStroke {
    return ^ SJAttributeWorker *(float border, UIColor *color){
        _r_nextStrokeBorder = @(border);
        _r_nextStrokeColor = color;
        return self;
    };
}

- (SJAttributeWorker *(^)(void))nextLetterpress {
    return ^ SJAttributeWorker *(void) {
        _r_nextLetterpress = YES;
        return self;
    };
}

- (SJAttributeWorker *(^)(void))nextLink {
    return ^ SJAttributeWorker *(void) {
        _r_nextLink = YES;
        return self;
    };
}

- (SJAttributeWorker *(^)(float))nextOffset {
    return ^ SJAttributeWorker *(float nextOffset) {
        _r_nextOffset = @(nextOffset);
        return self;
    };
}

- (SJAttributeWorker *(^)(float))nextObliqueness {
    return ^ SJAttributeWorker *(float nextObliqueness) {
        _r_nextObliqueness = @(nextObliqueness);
        return self;
    };
}

#pragma mark -

- (SJAttributeWorker *(^)(UIImage *, NSInteger, CGPoint, CGSize))insertImage {
    return ^ SJAttributeWorker *(UIImage *image, NSInteger index, CGPoint offset, CGSize size) {
        if ( -1 == index ) index = _attrM.length;
        NSTextAttachment *attachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
        attachment.image = image;
        attachment.bounds = CGRectMake(offset.x, offset.y, size.width, size.height);
        self.insertAttr([NSAttributedString attributedStringWithAttachment:attachment], index);
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(NSAttributedString * _Nonnull, NSInteger))insertAttr {
    return ^ SJAttributeWorker *(NSAttributedString *attr, NSInteger index) {
        if ( -1 == index ) index = _attrM.length;
        [_attrM insertAttributedString:attr atIndex:index];
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(NSString * _Nonnull, NSInteger))insertText {
    return ^ SJAttributeWorker *(NSString *text, NSInteger index) {
        if ( -1 == index ) index = _attrM.length;
        self.insertAttr([[NSAttributedString alloc] initWithString:text], index);
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(id _Nonnull, ...))insert {
    return ^ SJAttributeWorker *(id insert, ...) {
        va_list args;
        va_start(args, insert);
        if      ( [insert isKindOfClass:[NSString class]] ) {
            self.insertText(insert, va_arg(args, NSInteger));
        }
        else if ( [insert isKindOfClass:[NSAttributedString class]] ) {
            self.insertAttr(insert, va_arg(args, NSInteger));
        }
        else if ( [insert isKindOfClass:[UIImage class]] ) {
            self.insertImage(insert, va_arg(args, NSInteger), va_arg(args, CGPoint), va_arg(args, CGSize));
        }
        va_end(args);
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(NSRange, id value))replace {
    return ^ SJAttributeWorker *(NSRange range, id value) {
        if ( [value isKindOfClass:[NSString class]] ) {
            [_attrM replaceCharactersInRange:range withString:value];
        }
        else if ( [value isKindOfClass:[NSAttributedString class]] ) {
            [_attrM replaceCharactersInRange:range withAttributedString:value];
        }
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(id _Nonnull, id _Nonnull))replaceIt {
    return ^ SJAttributeWorker *(id oldValue, id newValue) {
        if ( !_isStrOrAttrStr(oldValue) ) return self;
        if ( !_isStrOrAttrStr(newValue) ) return self;
        self.regexpRanges([oldValue string], ^(NSArray<NSValue *> * _Nonnull ranges) {
            [ranges enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                self.replace([obj rangeValue], newValue);
            }];
        });
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(NSRange))removeText {
    return ^ SJAttributeWorker *(NSRange range) {
        [_attrM deleteCharactersInRange:range];
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(NSAttributedStringKey _Nonnull, NSRange))removeAttribute {
    return ^ SJAttributeWorker *(NSAttributedStringKey key, NSRange range) {
        [_attrM removeAttribute:key range:range];
        return self;
    };
}

- (void (^)(void))clean {
    return ^ () {
        [_attrM enumerateAttributesInRange:_rangeAll(_attrM) options:NSAttributedStringEnumerationReverse usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
            [attrs enumerateKeysAndObjectsUsingBlock:^(NSAttributedStringKey  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                // 字体大小保持不变
                if ( [key isEqualToString:NSFontAttributeName] ) return;
                self.removeAttribute(key, range);
            }];
        }];
    };
}

#pragma mark -
- (SJAttributeWorker * _Nonnull (^)(NSString * _Nonnull, void (^ _Nonnull)(SJAttributeWorker * _Nonnull)))regexp {
    return ^ SJAttributeWorker *(NSString *ex, void(^task)(SJAttributeWorker *worker)) {
        self.regexpRanges(ex, ^(NSArray<NSValue *> * _Nonnull ranges) {
            [ranges enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                task(self);
                self.range(obj.rangeValue);
            }];
        });
        return self;
    };
}

- (SJAttributeWorker * _Nonnull (^)(NSString * _Nonnull, void (^ _Nonnull)(NSArray<NSValue *> * _Nonnull)))regexpRanges {
    return ^ SJAttributeWorker *(NSString *ex, void(^task)(NSArray<NSValue *> *ranges)) {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:ex options:kNilOptions error:nil];
        NSMutableArray *rangesM = [NSMutableArray new];
        [regex enumerateMatchesInString:_attrM.string options:NSMatchingWithoutAnchoringBounds range:_rangeAll(_attrM) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            [rangesM addObject:[NSValue valueWithRange:result.range]];
        }];
        if ( 0 != rangesM.count ) task(rangesM);
        else task(nil);
        return self;
    };
}

#pragma mark -
inline static BOOL _isStrOrAttrStr(id target) {
    return [target isKindOfClass:[NSString class]] || [target isKindOfClass:[NSAttributedString class]];
}

#pragma mark - Other
- (NSInteger)length {
    return _attrM.length;
}

- (CGFloat (^)(NSRange))width {
    return ^ CGFloat (NSRange range) {
        return self.size(range).width;
    };
}

- (CGSize (^)(NSRange))size {
    return ^ CGSize (NSRange range) {
        return [self boundsWithWidth:CGFLOAT_MAX height:CGFLOAT_MAX range:range].size;
    };
}

- (CGRect (^)(CGFloat))boundsByMaxWidth {
    return ^ CGRect (CGFloat maxWidth) {
        return [self boundsWithWidth:maxWidth height:CGFLOAT_MAX range:_rangeAll(_attrM)];
    };
}

- (CGRect (^)(CGFloat))boundsByMaxHeight {
    return ^ CGRect (CGFloat maxHeight) {
        return [self boundsWithWidth:CGFLOAT_MAX height:maxHeight range:_rangeAll(_attrM)];
    };
}

- (CGRect)boundsWithWidth:(CGFloat)width height:(CGFloat)height range:(NSRange)range {
    NSAttributedString *attr = self.attrStrByRange(range);
    [attr enumerateAttributesInRange:_rangeAll(attr) options:NSAttributedStringEnumerationReverse usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        __block BOOL isSetFont = NO;
        [attrs enumerateKeysAndObjectsUsingBlock:^(NSAttributedStringKey  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ( ![key isEqualToString:NSFontAttributeName] ) return;
            isSetFont = YES;
            *stop = YES;
        }];
        NSAssert(isSetFont, @"You need to set it font! Range = %@", NSStringFromRange(range));
    }];
    CGRect bounds = [attr boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    bounds.size.width = ceil(bounds.size.width);
    bounds.size.height = ceil(bounds.size.height);
    return bounds;
}

- (NSAttributedString * _Nonnull (^)(NSRange))attrStrByRange {
    return ^ NSAttributedString *(NSRange range) {
        [self _pauseTask];
        NSAttributedString *attr = [_attrM attributedSubstringFromRange:range];
        return attr;
    };
}

#pragma mark -

inline static NSRange _rangeAll(NSAttributedString *attr) {
    return NSMakeRange(0, attr.length);
}

- (NSMutableParagraphStyle *)style {
    if ( _style ) return _style;
    _style = [NSMutableParagraphStyle new];
    return _style;
}

- (NSMutableDictionary<NSString *, NSNumber *> *)r_paragraphStylePropertiesM {
    if ( _r_paragraphStylePropertiesM ) return _r_paragraphStylePropertiesM;
    _r_paragraphStylePropertiesM = [NSMutableDictionary new];
    return _r_paragraphStylePropertiesM;
}

- (NSMutableDictionary<NSValue *,NSParagraphStyle *> *)localParagraphStyleDictM {
    if ( _localParagraphStyleDictM ) return _localParagraphStyleDictM;
    _localParagraphStyleDictM = [NSMutableDictionary new];
    return _localParagraphStyleDictM;
}

@end
