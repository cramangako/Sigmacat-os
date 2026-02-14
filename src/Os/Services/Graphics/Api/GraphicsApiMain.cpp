#include <stdint.h>
#include "../graphics.h"
#include "GraphicsApi.h"

uint16_t CenterScreenX;
uint16_t CenterScreenY;

#define MessageBoxTextColor 29,29,29
#define MessageBoxColor 255,255,238
#define MessageBoxZindex 11
#define BorderSize 7

#define MessageBoxTextPaddingX 10

#define MessageBox_NameTag_SizeY 20
#define MessageBox_NameTag_Color 52,41,27
#define MessageBox_NameTag_Color_Text 255,255,255



bool isMessageBoxActive;



void Draw_Rectangle(uint16_t centerX, uint16_t centerY, uint16_t width,uint16_t height, uint8_t Zindex, uint8_t Red,uint8_t Green,uint8_t Blue){

    int startX = centerX - (width / 2);
    int startY = centerY - (height / 2);


    int endX = centerX + (width / 2);
    int endY = centerY + (height / 2);

    SetLayer(Zindex);

    for(int y = startY; y < endY; y++){

        for(int x = startX; x < endX; x++){
            SetPixel(x,y,Red,Green,Blue);
        }
    }

    SetLayer(0);
}


//why are you even reading ts? answer here :                 <---- THERE!
void Draw_MessageBox(char Text[256],char Name[100]){

    int16_t BoxWidth = 500;
    int16_t BoxHeight = 250;


    CenterScreenX = horizontal /2;
    CenterScreenY = vertical /2;


    ClearScreen(); // clear cuz ion know how to save old pixels and ion know bruh


    Draw_Rectangle(CenterScreenX,CenterScreenY,BoxWidth,BoxHeight,MessageBoxZindex,MessageBoxColor);
    Draw_Rectangle(CenterScreenX,CenterScreenY,BoxWidth + BorderSize,BoxHeight + BorderSize,MessageBoxZindex -1 ,84,84,84);
    Draw_Rectangle(CenterScreenX,CenterScreenY /1.43 ,BoxWidth,MessageBox_NameTag_SizeY,MessageBoxZindex +1 ,MessageBox_NameTag_Color); //   the thing under the name
    SetLayer(12);


    int amountToPrint = 0;
    int amountToPrint_name = 0;

    while(Text[amountToPrint] != '\0') amountToPrint++;
    while(Name[amountToPrint_name] != '\0') amountToPrint_name++;

    int PrintPosX = CenterScreenX - (BoxWidth /2);
    int PrintPosY = CenterScreenY - (BoxHeight /3);

    int NamePosX = CenterScreenX - (BoxWidth /5);
    int NamePosY = CenterScreenY - (BoxHeight /2.1);

    

    int startPrintX = PrintPosX;

    const int lineHeight = 8 + 6;

    isMessageBoxActive = true;


    for (int i = 0; i < amountToPrint; i++) {
        char ToPrint = Text[i];


        if (ToPrint == '\r') continue;

        if (ToPrint == '\n') {
            PrintPosX = startPrintX;
            PrintPosY += lineHeight;
        } else {
            DrawCharacter(ToPrint, PrintPosX, PrintPosY, MessageBoxTextColor, MessageBoxColor);
            PrintPosX += MessageBoxTextPaddingX;
        }
    }




    for(int i = 0; i < amountToPrint_name; i++){
        char ToPrint = Name[i];




        DrawCharacter(ToPrint, NamePosX, NamePosY, MessageBox_NameTag_Color_Text, MessageBox_NameTag_Color);

        NamePosX += MessageBoxTextPaddingX;
    }

    SetLayer(0);



}


void NewMessageBoxAction(){
    if(isMessageBoxActive){
        //clear more
        ClearLayer(MessageBoxZindex - 1);
        ClearLayer(MessageBoxZindex);
        ClearLayer(MessageBoxZindex + 1);

        ClearLayer(12);


        ClearScreen();
        isMessageBoxActive = false;
    }
}