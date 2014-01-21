//
//  ViewController.m
//  AttributeStringApp
//
//  Created by Ovi Bortas on 1/21/14.
//  Copyright (c) 2014 Ovi Bortas. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textBody;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setupOutlineButton];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Check the segue identifier
    if ([segue.identifier isEqualToString:@"DetailsSegue"]) {
        
        // If the current segues is going to this class
        if ([segue.destinationViewController isKindOfClass:[DetailViewController class]]) {
            
            // Give me a pointer to it
            DetailViewController *DVC = (DetailViewController *)segue.destinationViewController;
            // Set the needed data
            DVC.textToAnalyze = self.textBody.textStorage;
        }
    }
}

- (void)setupOutlineButton
{
    if (self.outlineButton.currentTitle) {
        // Get a mutableAttributedString from the current button title
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:self.outlineButton.currentTitle];
        
        // Give that MAString some attributes
        [title setAttributes:@{NSStrokeWidthAttributeName : @3, NSStrokeColorAttributeName : self.outlineButton.tintColor} range:NSMakeRange(0, [title length])];
        
        // Set it back as the current title to display
        [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
                                            
    }
}

#pragma mark - Change text atributes
// Adds color to the selected text
- (IBAction)colorButtonTapped:(UIButton *)sender
{
    [self.textBody.textStorage addAttribute:NSForegroundColorAttributeName value:sender.backgroundColor range:self.textBody.selectedRange];
}

// Add outline to selected text
- (IBAction)outlineText:(id)sender
{
    [self.textBody.textStorage addAttributes:@{NSStrokeWidthAttributeName : @-3, NSStrokeColorAttributeName : [UIColor blackColor]} range:self.textBody.selectedRange];
}

// Unoutlines the selected text
- (IBAction)unoutlineText:(id)sender
{
    [self.textBody.textStorage removeAttribute:NSStrokeWidthAttributeName range:self.textBody.selectedRange];
}


@end
