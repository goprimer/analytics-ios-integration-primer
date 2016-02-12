
#import <Foundation/Foundation.h>

#import <Analytics/SEGIntegrationFactory.h>

@interface SEGPrimerIntegrationFactory : NSObject <SEGIntegrationFactory>

// Primer needs to be initialized early in order to work correctly.
// The factory accepts the Primer token and initializes it for you.
+ (instancetype)instanceWithToken:(NSString *)token;

@end
