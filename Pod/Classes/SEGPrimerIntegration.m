
#import "SEGPrimerIntegration.h"

#import <Analytics/SEGAnalytics.h>
#import <Analytics/SEGAnalyticsUtils.h>
#import <Primer/Primer.h>

@interface SEGPrimerIntegration ()

@property (nonatomic, strong) NSMutableArray *forwardedEventIDs;

@end

@implementation SEGPrimerIntegration

- (id)initWithSettings:(NSDictionary *)settings
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _settings = settings;
    _forwardedEventIDs = [NSMutableArray array];
    
    SEGLog(@"Subscribing to Primer Event Fired Notifications.");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePrimerEventFiredNotification:) name:PMREventFiredNotification object:nil];
    
    return self;
}

- (void)track:(SEGTrackPayload *)payload
{
    NSString *eventID = payload.properties[@"pmr_event_id"];
    if (eventID && [self.forwardedEventIDs containsObject:eventID]) {
        [self.forwardedEventIDs removeObject:eventID];
        return;
    }
    
    NSMutableDictionary *segmentProperties = [NSMutableDictionary dictionary];
    segmentProperties[@"segment_context"] = payload.context ?: @{};
    segmentProperties[@"segment_integrations"] = payload.integrations ?: @{};
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:payload.properties];
    parameters[@"integration_source"] = @"segment-ios";
    parameters[@"segment_properties"] = segmentProperties;
    
    SEGLog(@"[Primer trackEventWithName:%@ parameters:%@]", payload.event, parameters);
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
    
    NSDictionary *userInfo = notification.userInfo;
    if (!userInfo && [notification.object isKindOfClass:[NSDictionary class]]) {
        userInfo = notification.object;
    }
    
    if (!userInfo) {
        return;
    }
    
    NSString *name = userInfo[PMREventNotificationNameKey];
    if (name.length < 1) {
        return;
    }
    
    NSDictionary *parameters = userInfo[PMREventNotificationParametersKey] ?: @{};
    NSMutableDictionary *properties = [NSMutableDictionary dictionaryWithDictionary:parameters];
    properties[@"integration_source"] = @"segment-ios";
    
    NSString *eventID = parameters[@"pmr_event_id"];
    if (eventID) {
        [self.forwardedEventIDs addObject:eventID];
    }
    
    SEGLog(@"Forwarding Primer event %@ with properties: %@", name, properties);
    [[SEGAnalytics sharedAnalytics] track:name properties:properties];
}

@end
