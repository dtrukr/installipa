#include <CoreFoundation/CoreFoundation.h>
#include <stdio.h>

#ifndef MOBILEINSTALLATION_H_
#define MOBILEINSTALLATION_H_
typedef void (*MobileInstallationCallback)(CFDictionaryRef information);
int MobileInstallationInstall(CFStringRef path, CFDictionaryRef parameters, MobileInstallationCallback callback, void *unknown);
#endif

int main(int argc, char **argv, char **envp)
{
    int ret;

    if (argc < 2) {
        fprintf(stderr, "Usage: %s path/to/file.ipa \n", argv[0]);
        return -1;
    }

    CFStringRef path = CFStringCreateWithCString(kCFAllocatorDefault, argv[1], kCFStringEncodingUTF8);
    assert(path != NULL);

    ret = MobileInstallationInstall(path, NULL, NULL, NULL);

    if (ret != 0) {
        fprintf(stderr, "Couldn't install application: %s. Reason: %i, ", argv[1], ret);
    }

    CFRelease(path);

    return ret;
}
