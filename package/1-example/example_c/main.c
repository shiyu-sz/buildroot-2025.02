
#include <stdio.h>
#include <unistd.h>
#include <syslog.h>

#define LOGI(...) syslog(LOG_INFO, __VA_ARGS__)
#define LOGW(...) syslog(LOG_WARNING, __VA_ARGS__)
#define LOGE(...) syslog(LOG_ERR, __VA_ARGS__)
#define LOGD(...) syslog(LOG_DEBUG, __VA_ARGS__)

int main(int argc, char *argv[])
{
    int count = 0;
    int time = atoi(argv[1]);
    openlog("example_c", LOG_CONS, LOG_USER);
    while(1)
    {
        printf("buildroot helloworld! V1\n");
        LOGI("count = %d", count);
        LOGI("This is an informational message.");
        LOGW("This is a warning message.");
        LOGE("This is an error message.");
        LOGD("This is an error message.");
        usleep(time);
        count ++;
    }
    return 0;
}