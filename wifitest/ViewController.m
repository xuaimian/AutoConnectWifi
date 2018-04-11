//
//  ViewController.m
//  wifitest
//
//  Created by spring on 2018/4/11.
//  Copyright © 2018年 spring. All rights reserved.
//

#import "ViewController.h"
#import <NetworkExtension/NetworkExtension.h>
#import <SystemConfiguration/CaptiveNetwork.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NEHotspotConfiguration* configuration = [[NEHotspotConfiguration alloc]initWithSSID:@"Sabai24" passphrase:@"sabaipass123" isWEP:NO];
    
    [[NEHotspotConfigurationManager sharedManager] applyConfiguration:configuration completionHandler:^(NSError * _Nullable error) {
        if ([[self getCurrentWifi] isEqualToString:@"Sabai24"]) {
            if (error){
                NSLog(@"errordes:%@",error);
            }else{
                NSLog(@"加入网络成功");
            }
        }
 
    }];


    // Do any additional setup after loading the view, typically from a nib.
}

-(NSString*)getCurrentWifi{
    
    NSString* wifiName =@"";

    CFArrayRef wifiInterfaces =CNCopySupportedInterfaces();
    
    if(!wifiInterfaces) {
        
        wifiName =@"";
        
    }
    
    NSArray*interfaces = (__bridge NSArray*)wifiInterfaces;
    
    for(NSString*interfaceName in interfaces) {
        
        CFDictionaryRef dictRef =CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if(dictRef) {
            
            NSDictionary*networkInfo = (__bridge NSDictionary*)dictRef;
            
            wifiName = [networkInfo objectForKey:(__bridge NSString*)kCNNetworkInfoKeySSID];
            
            CFRelease(dictRef);
            
        }
        
    }
    
    CFRelease(wifiInterfaces);
    
    return wifiName;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
