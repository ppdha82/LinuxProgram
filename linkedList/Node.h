#pragma once

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
