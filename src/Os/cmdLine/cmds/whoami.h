#include "../../../Kernel/Kernel_Services.h"
#include "../../../Kernel/commonKernel.h"
#include "../../../Os/Services/Graphics/graphics.h"

int WhoAmI(struct Command *ToRun){
    PrintLn("sigmacat",255,255,255); // it was either root or sigmacat
    return 0;
}