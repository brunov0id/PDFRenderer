//
//  PDFViewController.m
//  PDFRenderer
//
//  Created by Bruno on 10/22/14.
//  Copyright (c) 2014 Bruno. All rights reserved.
//

#import "PDFViewController.h"

static NSString *text = @"";

@interface PDFViewController ()

@end

@implementation PDFViewController

- (void)viewDidLoad {
    
    [self drawPDF];
    [self showPDFFile];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)drawPDF
{
    NSString *pdfFileName = [self getFileName];
    
    NSString *textToDraw = [self getText];
    
    CFStringRef stringRef = (__bridge CFStringRef)textToDraw;
    
    CFAttributedStringRef currentText = CFAttributedStringCreate(NULL, stringRef, NULL);
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(currentText);
    
    CGRect frameRect = CGRectMake(0, 0, 300, 50);
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, frameRect);
    
    CFRange currentRange = CFRangeMake(0, 0);
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, NULL);
    CGPathRelease(framePath);
    
    UIGraphicsBeginPDFContextToFile(pdfFileName, CGRectZero, nil);
    
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
    
    CGContextTranslateCTM(currentContext, 0, 100);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    CTFrameDraw(frameRef, currentContext);
    
    CFRelease(frameRef);
    CFRelease(stringRef);
    CFRelease(framesetter);
    
    UIGraphicsEndPDFContext();
}

-(void)showPDFFile
{
    NSString *pdfFileName = [self getFileName];
    
    NSURL *url = [NSURL fileURLWithPath:pdfFileName];
    NSData *pdfData = [[NSData alloc] initWithContentsOfURL:url];
    
    [self.webView setScalesPageToFit:YES];
    [self.webView loadData:pdfData MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:nil];
}

-(NSString *)getFileName
{
    NSString *fileName = @"0din.pdf";
    
    NSArray *arrPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *path = [arrPaths objectAtIndex:0];
    return [path stringByAppendingPathComponent:fileName];
}

-(void)send:(NSString *)name email:(NSString *)email message:(NSString *)message
{
    text = [NSString stringWithFormat:@"Name: %@ \nEmail: %@ \nMessage: %@",name,email,message];
}

-(NSString *)getText
{
    return text;
}

@end
