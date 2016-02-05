//
//  NSObject+BUI.h
//  GTCommonUI
//
//  Created by Mateusz Szlosek on 05.02.2016.
//  Copyright © 2016 good. All rights reserved.
//

#import <Foundation/Foundation.h>


/*! @category NSObject(BUI)
 *
 *  Category to fix Apple issue with iPhone 6+ in landscape orientation
 *  when clicking on BUI/copy/paste/cut on the keyboard when @p UIWebView
 *  is the first responder. 
 *
 *  @discussion Apple has a bug, that it sends @p _responderForEditing
 *  method to @p UIThreadSafeNode, but @p UIThreadSafeNode is a subclass of @p NSObject
 *  not @p UIResponder.
 *
 *  @author Mateusz Szlosek
 */
@interface NSObject(BUI)

@end
