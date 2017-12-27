#include <cstdio>
#include <string>
#include <iostream>
#include "LinkedAction.h"

int main(void)
{
    SLL* rainbow = new SLL();

    rainbow->CreateLinkToFirst("»¡°­");
    rainbow->CreateLinkToFirst("ÁÖÈ²");
    rainbow->CreateLinkToFirst("³ë¶û");
    rainbow->CreateLinkToFirst("ÃÊ·Ï");
    rainbow->CreateLinkToFirst("ÆÄ¶û");
    rainbow->CreateLinkToFirst("³²»ö");
    rainbow->CreateLinkToFirst("º¸¶ó");
    rainbow->InsertLinkToIndex("¸Þ·Õ", 3);
    rainbow->InsertLinkToIndex("¹¹¶ó", 1);
    rainbow->InsertLinkToIndex("¿Ó´õ", 0);
    rainbow->InsertLinkToIndex("Á¨Àå", 1);
    rainbow->InsertLinkToIndex("²¨Áü", 19);
    rainbow->RemoveLinkAt(0);
    rainbow->RemoveLinkAt(5);
    rainbow->InsertLinkToIndex("¿Ø°É");

    rainbow->PrintAll();
    rainbow->ImplementKeyword("¹¹¶ó", "¹¹¶óÄ«³ë");
    rainbow->PrintAll();

    return 0;
}