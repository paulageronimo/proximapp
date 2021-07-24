//
//  BackgroundVideo.h
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/23/21.
//
//  Created by Adam Albarghouthi on 2016-06-26.
//  Copyright © 2016 backgroundVideo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface BackgroundVideo : NSObject {
    NSURL *videoURL;
    UIViewController *viewController;
}

@property (strong, nonatomic) AVPlayer *backgroundPlayer;

- (id)initOnViewController:(UIViewController *)onViewController withVideoURL:(NSString *)url;
- (void)setUpBackground;

@end
