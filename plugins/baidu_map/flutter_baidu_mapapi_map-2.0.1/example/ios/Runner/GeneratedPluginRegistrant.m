//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flutter_baidu_mapapi_base/FlutterBmfbasePlugin.h>)
#import <flutter_baidu_mapapi_base/FlutterBmfbasePlugin.h>
#else
@import flutter_baidu_mapapi_base;
#endif

#if __has_include(<flutter_baidu_mapapi_map/FlutterBmfmapPlugin.h>)
#import <flutter_baidu_mapapi_map/FlutterBmfmapPlugin.h>
#else
@import flutter_baidu_mapapi_map;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterBmfbasePlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterBmfbasePlugin"]];
  [FlutterBmfmapPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterBmfmapPlugin"]];
}

@end
