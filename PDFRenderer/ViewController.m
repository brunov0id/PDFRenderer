//
//  ViewController.m
//  PDFRenderer
//
//  Created by Bruno on 10/22/14.
//  Copyright (c) 2014 Bruno. All rights reserved.
//

#import "ViewController.h"
#import "PDFViewController.h"

@interface ViewController ()
{
    PDFViewController *pdf;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"pdf"])
    {
        if (!pdf)
        {
            pdf = [[PDFViewController alloc] init];
        }
        [pdf send:self.outletName.text email:self.outletEmail.text message:self.outletMessage.text];
        [self clear];
    }
}

-(void)clear
{
    self.outletName.text = @"";
    self.outletEmail.text = @"";
    self.outletMessage.text = @"";
}

@end
