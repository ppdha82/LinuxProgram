#include <cstdio>
#include <string>
#include <iostream>

class Node
{
private:
    std::string txt;
    Node* tail;
public:
    void setText(std::string source)
    {
        txt = source;
    }
    
    std::string getText(void)
    {
        return txt;
    }

    void setTail(Node* target)
    {
        tail = target;
    }

    Node* getTail(void)
    {
        return tail;
    }
};

class SLL
{
private:
    Node* LinkHead;
    Node* currentPoint;
    Node* previousPoint;

public:
    SLL()
    {
        LinkHead = NULL;
    }

    void CreateLinkToFirst(std::string txt)
    {
        Node* temp = new Node();

        temp->setText(txt);
        temp->setTail(LinkHead);
        LinkHead = temp;
    }

    void connectNewLinkWith(Node* curLink, Node* prevLink, std::string txt)
    {
        if (prevLink == NULL)
        {
            CreateLinkToFirst(txt);
            return;
        }
        Node* temp = new Node();
        temp->setText(txt);
        temp->setTail(curLink);
        prevLink->setTail(temp);
    }

    void InsertLinkToIndex(std::string txt, int index)
    {
        int linkSize = 0;
        int countIndex = index;
        currentPoint = LinkHead;
        previousPoint = NULL;
        linkSize++;
        
        while (currentPoint->getTail() != NULL)
        {
            if (countIndex == 0)
            {
                connectNewLinkWith(currentPoint, previousPoint, txt);
                std::cout << "Current[" << index << "] : " << currentPoint->getText() << std::endl;
                break;
            }

            countIndex--;
            if (countIndex < 0)
            {
                break;
            }
            linkSize++;
            previousPoint = currentPoint;
            currentPoint = currentPoint->getTail();
        }

        if (countIndex > 0)
        {
            std::cout << "Index(" << index << ") is bigger than size(" << linkSize << ") of current link" << std::endl;
        }
    }

    void RemoveLinkAt(int index)
    {
        int linkSize = 0;
        int countIndex = index;
        currentPoint = LinkHead;
        previousPoint = NULL;
        linkSize++;

        if (currentPoint == NULL)
        {
            std::cout << "There is no one link" << std::endl;
            return;
        }

        if (countIndex == 0)
        {
            LinkHead = currentPoint->getTail();
            return;
        }

        while (currentPoint->getTail() != NULL)
        {
            previousPoint = currentPoint;
            currentPoint = currentPoint->getTail();
            countIndex--;

            if (countIndex == 0)
            {
                Node* nextPoint = currentPoint->getTail();
                std::cout << "Removed item : " << nextPoint->getText() << std::endl;
                currentPoint->setTail(nextPoint->getTail());
                break;
            }
            linkSize++;
        }

        if (countIndex > 0)
        {
            std::cout << "Index(" << index << ") is bigger than size(" << linkSize << ") of current link" << std::endl;
        }
    }

    void PrintAll(void)
    {
        currentPoint = LinkHead;

        while (currentPoint->getTail() != NULL)
        {
            std::cout << currentPoint->getText() << "-> ";
            currentPoint = currentPoint->getTail();
        }
        std::cout << currentPoint->getText() << std::endl;
    }
};

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

    rainbow->PrintAll();

    return 0;
}