//
//  ViewController.m
//  Veeva Simulator
//
//  Created by JJ Mifsud on 2014-10-30.
//  Copyright (c) 2014 JJ Mifsud. All rights reserved.
//

#import "ViewController.h"

#define ll8 int

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *veevaView;

@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden {return YES;}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSError *error = nil;
    NSString *yourFolderPath = @"Documents";
    NSArray  *yourFolderContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:yourFolderPath error:&error];
    NSString *fileToLoad = nil;
    
    for (NSString *object in yourFolderContents) {
//        NSLog(@"%@", object);
//        NSLog(@"%@", [object class]);
//        NSLog(@"%@", [object pathExtension]);
        
        if ([[object pathExtension] isEqualToString:@"html"])
        {
            fileToLoad = [object substringToIndex: [object length] - 5];
            
            
            NSLog(@"%@", fileToLoad);
            break;
        }
        
        else {
            NSLog(@"NO");
        }
        
        NSLog(@"===================================");
    }
    
    if (!fileToLoad) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sup Bro" message:@"Yo got no HTMLz in here" delegate:self cancelButtonTitle:@"Ok, Cool" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    fileToLoad = [NSString stringWithFormat:@"html/%@",  fileToLoad];
    
    NSURL * resourcePathURL = [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource:@"html/index" ofType:@"html"]];
    if(resourcePathURL)
    {
        NSURLRequest * req = [NSURLRequest requestWithURL: resourcePathURL];
        [self.veevaView loadRequest: req];
    }

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
