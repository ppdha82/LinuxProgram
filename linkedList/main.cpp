#include <cstdio>
#include <string>
#include <iostream>
#include "LinkedAction.h"

int main(void)
{
    SLL* rainbow = new SLL();

    rainbow->CreateLinkToFirst("����");
    rainbow->CreateLinkToFirst("��Ȳ");
    rainbow->CreateLinkToFirst("���");
    rainbow->CreateLinkToFirst("�ʷ�");
    rainbow->CreateLinkToFirst("�Ķ�");
    rainbow->CreateLinkToFirst("����");
    rainbow->CreateLinkToFirst("����");
    rainbow->InsertLinkToIndex("�޷�", 3);
    rainbow->InsertLinkToIndex("����", 1);
    rainbow->InsertLinkToIndex("�Ӵ�", 0);
    rainbow->InsertLinkToIndex("����", 1);
    rainbow->InsertLinkToIndex("����", 19);
    rainbow->RemoveLinkAt(0);
    rainbow->RemoveLinkAt(5);
    rainbow->InsertLinkToIndex("�ذ�");

    rainbow->PrintAll();
    rainbow->ImplementKeyword("����", "����ī��");
    rainbow->PrintAll();

    return 0;
}