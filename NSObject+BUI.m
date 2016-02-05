//
//  NSObject+BUI.m
//  GTCommonUI
//
//  Created by Mateusz Szlosek on 05.02.2016.
//  Copyright © 2016 good. All rights reserved.
//

#import "NSObject+BUI.h"

/*!
 *  Helper category to get "real" first responder. 
 *  This should give us UIWebBrowserView.
 */
@interface UIView (FirstResponder)

/*!
 *  @brief Method goes down on subviews and finds first responder.
 *
 *  @return UIView which is the firstResponder
 */
-(__nullable id)findFirstResponder;

@end

@implementation UIView (FirstResponder)

- (__nullable id)findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        id responder = [subView findFirstResponder];
        if (responder) return responder;
    }
    return nil;
}

@end

@implementation NSObject(BUI)

/*!
 *  Missing method from @p UIResponder.
 *
 *  @return returns self, in this case instance of @p UIThreadSafeNode class.
 */
-(_Nonnull id)_responderForEditing
{
    return self;
}

/*!
 *  Similar to -copy: method, but we have to remove selected text as well.
 *
 *  @param sender nil
 */
-(void)cut:(nullable id) __unused sender
{
    NSString *selection = [[self getWebView] stringByEvaluatingJavaScriptFromString:@"window.getSelection().toString()"];
    [[self getWebView] stringByEvaluatingJavaScriptFromString:@"document.execCommand('delete', false, null)"];
    [UIPasteboard generalPasteboard].string = selection;
}

/*!
 *  Insert text from pasteboard into HTML document.
 *
 *  @param sender nil
 */
-(void)paste:(nullable id) __unused sender
{
    NSString *text = [UIPasteboard generalPasteboard].string;
    [[self getWebView] stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('insertHTML', false, '%@')", text]];
}

/*!
 *  Get selected text and save it in pasteboard
 *
 *  @param sender nil
 */
-(void)copy:(nullable id) __unused sender
{
    NSString *selection = [[self getWebView] stringByEvaluatingJavaScriptFromString:@"window.getSelection().toString()"];
    [UIPasteboard generalPasteboard].string = selection;
}

/*!
 *  Calls javascript on @b UIWebView to toggle Italics font
 *
 *  @param sender nil
 */
-(void)toggleItalics:(nullable id) __unused sender
{
    [[self getWebView] stringByEvaluatingJavaScriptFromString:@"document.execCommand(\"Italic\")"];
}

/*!
 *  Calls javascript on @b UIWebView to toggle Underline font
 *
 *  @param sender nil
 */
-(void)toggleUnderline:(nullable id) __unused sender
{
    [[self getWebView] stringByEvaluatingJavaScriptFromString:@"document.execCommand(\"Underline\")"];
}

/*!
 *  Calls javascript on @b UIWebView to toggle Bold font
 *
 *  @param sender nil
 */
-(void)toggleBoldface:(nullable id) __unused sender
{
    [[self getWebView] stringByEvaluatingJavaScriptFromString:@"document.execCommand(\"Bold\")"];
}

/*!
 *  @b UIWebView is a superview of the superview of @b UIWebBrowserView.
 *
 *  @return instance of the WebView or nil if not found.
 */
-(UIWebView * __nullable)getWebView
{
    UIWebView *retVal = nil;
    id obj = [[[[[UIApplication sharedApplication] keyWindow] findFirstResponder] superview] superview];
    if ([obj  isKindOfClass:[UIWebView class]]) {
        retVal = obj;
    }
    return retVal;
}


@end
