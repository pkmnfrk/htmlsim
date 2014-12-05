//
//  ViewController.m
//  Veeva Simulator
//
//  Created by JJ Mifsud on 2014-10-30.
//  Copyright (c) 2014 JJ Mifsud. All rights reserved.
//

#import "ViewController.h"
#import "MyURLCache.h"

#define ll8 int

@interface ViewController () <UIWebViewDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *veevaView;
@property (strong, nonatomic) UIAlertView * loadingAlert;
@property int loadnum;
@property (strong, nonatomic) NSURLRequest * lastReq;
@property (strong, nonatomic) NSURLRequest * toLoad;
@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden {return YES;}

-(void)loadPage {
    //[[NSURLCache sharedURLCache] removeAllCachedResponses];
    
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
        if (self.toLoad){
            [[NSURLCache sharedURLCache] removeCachedResponseForRequest:self.lastReq];
            [[NSURLCache sharedURLCache] removeAllCachedResponses];
        
        }
        
        self.toLoad = [NSURLRequest requestWithURL:resourcePathURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];

        NSURLRequest * req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]];
        
        [self.veevaView loadRequest: req];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //to prevent internal caching of webpages in application
    //NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
    //[NSURLCache setSharedURLCache:sharedCache];
    
    MyURLCache * cache = [[MyURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
    [NSURLCache setSharedURLCache:cache];
    
    self.veevaView.delegate = self;

    [self loadPage];
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
                urlString = [NSString stringWithFormat:@"%@?v=%d", urlString, self.loadnum++];
                NSLog(@"%@", urlString);
                return urlString;//[urlString substringToIndex:[urlString length] -5];
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

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if(motion == UIEventSubtypeMotionShake && !self.loadingAlert) {
        self.loadingAlert = [[UIAlertView alloc] initWithTitle:@"Loading" message:@"Loading" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [self.loadingAlert show];
        [self loadPage];
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    if(self.loadingAlert) {
        [self.loadingAlert dismissWithClickedButtonIndex:0 animated:YES];
    }
    
    if(self.toLoad) {
        self.lastReq = self.toLoad;
        self.toLoad = nil;
        
        [self.veevaView loadRequest:self.lastReq];
    }
}


-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    self.loadingAlert = nil;
}

@end
