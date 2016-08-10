
#import "SEGPrimerIntegration.h"

#import <Analytics/SEGAnalytics.h>
#import <Analytics/SEGAnalyticsUtils.h>
#import <Primer/Primer.h>

@implementation SEGPrimerIntegration

- (id)initWithSettings:(NSDictionary *)settings
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _settings = settings;
    
    SEGLog(@"Subscribing to Primer Event Fired Notifications.");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePrimerEventFiredNotification:) name:PMREventFiredNotification object:nil];
    
    return self;
}

- (void)track:(SEGTrackPayload *)payload
{
    NSMutableDictionary *segmentProperties = [NSMutableDictionary dictionary];
    segmentProperties[@"segment_context"] = payload.context ?: @{};
    segmentProperties[@"segment_integrations"] = payload.integrations ?: @{};
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:payload.properties];
    parameters[@"integration_source"] = @"segment-ios";
    parameters[@"segment_properties"] = segmentProperties;
    
    SEGLog(@"[Primer trackEventWithName:%@ properties:%@]", payload.event, parameters);
    [Primer trackEventWithName:payload.event parameters:parameters];
}

- (void)identify:(SEGIdentifyPayload *)payload
{
    NSMutableDictionary *properties = [NSMutableDictionary dictionaryWithDictionary:payload.traits];
    properties[@"segment_anonymous_id"] = payload.anonymousId ?: @"";
    properties[@"segment_user_id"] = payload.userId ?: @"";
    
    SEGLog(@"[Primer appendUserProperties:%@]", properties);
    [Primer appendUserProperties:properties];
}

- (void)handlePrimerEventFiredNotification:(NSNotification *)notification
{
    if (![notification.name isEqualToString:PMREventFiredNotification]) {
        return;
    }
    
    NSString *name = notification.userInfo[PMREventNotificationNameKey];
    NSDictionary *parameters = notification.userInfo[PMREventNotificationParametersKey];
    
    NSMutableDictionary *properties = [NSMutableDictionary dictionaryWithDictionary:parameters];
    properties[@"integration_source"] = @"segment-ios";
    
    [[SEGAnalytics sharedAnalytics] track:name properties:properties];
}

@end
