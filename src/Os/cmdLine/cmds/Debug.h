#include "../../../Kernel/Kernel_Services.h"
#include "../../../Kernel/commonKernel.h"
#include "../../../Kernel/Driver/Time/Pit/Pit.h"
#include "../../../Os/Services/Graphics/graphics.h"
#include "../../../Os/Services/Graphics/Api/GraphicsApi.h"

int GetPitTime(struct Command *ToRun){
    char output[67];
    sprintf(output,"Current Tick: %d",time_tick);
    PrintLn(output,255,255,255);
    return 0;
}


int SleepFor(struct Command *ToRun){
    sleep_tick(5);
    return 0;
}


int MessageBox(struct Command *ToRun){
    Draw_MessageBox(
        "Behind the phosphor glow and pixel lattice,\n"
        "where vertices wait in ordered silence\n"
        "and buffers hum with mapped memory,\n"
        "there is a cat.\nWhile I define pipelines"
        "and negotiate with the GPU\n"
        "over fragments and depth tests\n"
        "she negotiates with gravity\n"
        "at the edge of the desk.\n"
        "Each time I misplace a semicolon\n"
        "or mismatch a uniform,"
        "I feel her stare\n allocate itself"
        "directly into my stack frame—\n"
        "a debugger without breakpoints,\n"
        "Her world has no z-buffer \nNo back-face culling.\n"
        "a silent assertion failure of focus.\n",
        "OMG WOW THIS WORKS!"
    );
    return 0;
}