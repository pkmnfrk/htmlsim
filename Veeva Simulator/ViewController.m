//
//  ViewController.m
//  Veeva Simulator
//
//  Created by JJ Mifsud on 2014-10-30.
//  Copyright (c) 2014 JJ Mifsud. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *veevaView;

@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden {return YES;}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSError *error = nil;
    NSString *yourFolderPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"html"];
    NSArray  *yourFolderContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:yourFolderPath error:&error];
    NSLog(@"%@", yourFolderContents);
    
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
