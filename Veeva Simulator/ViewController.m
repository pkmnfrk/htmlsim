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

    NSString *fileToLoad = [self findHtmlIndex];
    
//    NSError *error = nil;
//    NSString *yourFolderPath = @"Documents";
//    NSArray  *yourFolderContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:yourFolderPath error:&error];
//    NSString *fileToLoad = nil;
    
//    for (NSString *object in yourFolderContents) {
//        if ([[object pathExtension] isEqualToString:@"html"])
//        {
//            fileToLoad = [object substringToIndex: [object length] - 5];
//            
//            
//            NSLog(@"%@", fileToLoad);
//            break;
//        }
//        
//        else {
//            NSLog(@"NO");
//        }
//        
//        NSLog(@"===================================");
//    }
    
    if (!fileToLoad) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sup Bro" message:@"Yo got no HTMLz in here" delegate:self cancelButtonTitle:@"Ok, Cool" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    NSURL * resourcePathURL = [NSURL URLWithString:fileToLoad];
    
    NSLog(@"%@", resourcePathURL);
    
    if(resourcePathURL)
    {
        NSURLRequest * req = [NSURLRequest requestWithURL: resourcePathURL];
        [self.veevaView loadRequest: req];
    }

    // Do any additional setup after loading the view, typically from a nib.
}

- (NSString *) findHtmlIndex {
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];

    NSURL *directoryURL = [NSURL URLWithString:documentsPath];
    NSArray *keys = [NSArray arrayWithObject:NSURLIsDirectoryKey];
    
    NSDirectoryEnumerator *enumerator = [fileManager
                                         enumeratorAtURL:directoryURL
                                         includingPropertiesForKeys:keys
                                         options:0
                                         errorHandler:^(NSURL *url, NSError *error) {
                                             // Handle the error.
                                             // Return YES if the enumeration should continue after the error.
                                             return YES;
                                         }];
    
    for (NSURL *url in enumerator) {
        NSError *error;
        NSNumber *isDirectory = nil;
        
        if (! [url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:&error]) {
            // handle error
        }
        else if (! [isDirectory boolValue]) {
            // No error and it’s not a directory; do something with the file
            
            NSString *urlString = [url absoluteString];
            
  
            
            if ([[url pathExtension] isEqualToString:@"html"]) {
//                NSLog(urlString);
                return [urlString substringToIndex:[urlString length] -5];
            }
            

        }
        
        NSLog(@"============");
    }
    
    return nil;
//    return fileToOpen;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
