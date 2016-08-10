
#import <Foundation/Foundation.h>

#import <Analytics/SEGIntegrationFactory.h>

@interface SEGPrimerIntegrationFactory : NSObject <SEGIntegrationFactory>

// Primer needs to be started early in order to work correctly.
// The factory accepts the Primer token and starts it for you.
+ (instancetype)instanceWithToken:(NSString *)token;

@end
