#include <stdint.h>


extern   uint32_t horizontal;
extern uint32_t vertical;
extern uint32_t pitch;
extern uint8_t bitsPerPixel;



void SetPixel(uint32_t X, uint16_t Y, uint8_t Red, uint8_t Green, uint8_t Blue);

void InitGraphics(uint64_t framebuffer_addr, uint32_t h, uint32_t v, uint32_t p, uint8_t bpp);

void DrawCharacter(char Character,uint32_t Start_X, uint32_t Start_Y, uint8_t red, uint8_t green, uint8_t blue,uint8_t BgRed,uint8_t BgGreen,uint8_t BgBlue);


void RemoveDrawInput(int target);

void PrintLn(const char* Input, uint8_t Red, uint8_t Green, uint8_t Blue);

void ClearInputLine();

void ClearLine(int lineNumber);

void ClearScreen();

void FillScreenAndClear(uint8_t Red, uint8_t Green, uint8_t Blue);



void SetLayer(uint8_t layer);
uint8_t GetLayer();
void ClearLayer(uint8_t layer);

