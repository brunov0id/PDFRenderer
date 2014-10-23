//
//  PDFViewController.h
//  PDFRenderer
//
//  Created by Bruno on 10/22/14.
//  Copyright (c) 2014 Bruno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface PDFViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

-(void)send:(NSString *)name email:(NSString *)email message:(NSString *)message;

@end
