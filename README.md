# UIWebView-iPhone6-fix
There's a problem with iPhone 6+ landscape keyboard when editing text on UIWebView. After pressing BIU/copy/paste/cut app crashes.

# Summary:
NSObject category to solve issue with landscape iPhone 6+ keyboard when editing UIWebView.

# Code snippets:
- NSView (FirstResponder) category: http://stackoverflow.com/questions/1823317/get-the-current-first-responder-without-using-a-private-api
- UIWebView copy/paste/cut: http://stackoverflow.com/questions/16622032/uiwebview-execcommand-cut-copy-paste/16622300#16622300

## stackoverflow answer:
- http://stackoverflow.com/a/35204573/3488699
