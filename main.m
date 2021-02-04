#import <Cocoa/Cocoa.h>

//定义应用代理者
@interface AppDelegate : NSObject<NSWindowDelegate, NSApplicationDelegate>

@property (nullable, strong) NSStatusItem *statusItem;

- (void)applicationDidFinishLaunching:(NSNotification *)notification;
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication;
- (BOOL)windowShouldClose:(id)window;

@end

//实现应用代理者
@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    NSLog(@"看这里");
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength: NSSquareStatusItemLength];
    NSStatusBarButton *button = self.statusItem.button;

    NSURL* url = [NSURL URLWithString:@"https://www.baidu.com/favicon.ico"];

    [button setImage: [[NSImage alloc] initWithContentsOfURL: url]];

    button.target = self;
    button.action = @selector(handleButtonClick:);
    NSLog(@"看这里2");
}

- (void)handleButtonClick:(id)sender {
    NSLog(@"被点击3");
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

- (BOOL)windowShouldClose:(id)window {
    @autoreleasepool {
        NSAlert* alert = [NSAlert new];    
        [alert setAlertStyle: NSAlertStyleCritical];
        [alert setMessageText: @"确定退出"];
        [alert setIcon: nil];
        [alert addButtonWithTitle: @"是的, 关闭软件"];
        [alert addButtonWithTitle: @"不, 我点错了"];
        NSInteger result = [alert runModal];
        if (result == NSAlertFirstButtonReturn) {
            return YES;
        }
        return NO;   
    }
}
@end



int main(int argc, const char * argv[]) {
    //Objective-C 的 ARC, 不用操心  free 内存, 根据引用计数可以做到自动 release
    @autoreleasepool {
        //获取 app 的抽象对象
        NSApplication* app = [NSApplication sharedApplication];
        [app setActivationPolicy: NSApplicationActivationPolicyRegular];

        //主窗口 (如果只是状态栏程序, 主窗口是可选的)
        NSUInteger uiStyle = NSWindowStyleMaskTitled | NSWindowStyleMaskResizable | NSWindowStyleMaskClosable;
        NSWindow* win = [[NSWindow alloc] initWithContentRect: NSMakeRect(0, 0, 200, 300)
                                                    styleMask: uiStyle
                                                      backing: NSBackingStoreBuffered
                                                        defer:NO];
        [win setTitle:@"FizzX"];
        [win center];
        [win makeKeyAndOrderFront: win];
        [win makeMainWindow];

        //应用程序代理者
        AppDelegate* delegate = [AppDelegate new];
        [win setDelegate: delegate];
        [NSApp setDelegate: delegate];
        
        //NSApplication sharedApplication 会设置一个单例到 NSApp 中, 这里直接开启主事件 loop
        [NSApp run];
    }
    return 0;
}









