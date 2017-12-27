#pragma once
#include "Node.h"

class SLL
{
private:
	Node* LinkHead;

public:
	SLL()
	{
		LinkHead = NULL;
	}

    int sizeOfIndex(void)
    {
        Node* temp = LinkHead;
        int count = 0;

        while (temp != NULL)
        {
            temp = temp->getTail();
            count++;
        }

        return count;
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

	void InsertLinkToIndex(std::string txt, int index = 0)
	{
		int linkSize = 0;
		int countIndex = index;
		Node* currentPoint = LinkHead;
		Node* previousPoint = NULL;
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
		Node* currentPoint = LinkHead;
		Node* previousPoint = NULL;
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

    void ImplementKeyword(std::string source, std::string destination)
    {
        Node* temp = LinkHead;

        while (temp->getTail() != NULL)
        {
            if (temp->getText().find(source) != std::string::npos)
            {
                std::cout << "Found text(" << source << ") : " << temp->getText() << std::endl;
                std::string tempString;
                int targetSize = destination.length();
                int firstPositionOfSource = temp->getText().find(source);
                tempString = temp->getText();
                tempString.replace(firstPositionOfSource, targetSize, destination);
                std::cout << "Replace text(" << temp->getText() << ") = " << tempString << std::endl;
                temp->setText(tempString);
            }
            temp = temp->getTail();
        }
    }

	void PrintAll(void)
	{
		Node* currentPoint = LinkHead;

		while (currentPoint->getTail() != NULL)
		{
			std::cout << currentPoint->getText() << "-> ";
			currentPoint = currentPoint->getTail();
		}
		std::cout << currentPoint->getText() << std::endl;
        std::cout << "size of linked list = " << sizeOfIndex() << std::endl;
	}
};
