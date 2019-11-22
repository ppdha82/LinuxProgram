#include <fstream>
#include <iostream>
#include <string>
#include <array>
#include <vector>
#include <iterator>
#include <bmp.h>

std::vector<char> readBMP(const std::string &file)
{
	static constexpr size_t HEADER_SIZE = 54;

	std::ifstream bmp(file, std::ios::binary);

	std::array<char, HEADER_SIZE> header;
	bmp.read(header.data(), header.size());

	auto fileSize = *reinterpret_cast<uint32_t *>(&header[2]);
	auto dataOffset = *reinterpret_cast<uint32_t *>(&header[10]);
	auto width = *reinterpret_cast<uint32_t *>(&header[18]);
	auto height = *reinterpret_cast<uint32_t *>(&header[22]);
	auto depth = *reinterpret_cast<uint16_t *>(&header[28]);

	std::cout << "fileSize: " << fileSize << std::endl;
	std::cout << "dataOffset: " << dataOffset << std::endl;
	std::cout << "width: " << width << std::endl;
	std::cout << "height: " << height << std::endl;
	std::cout << "depth: " << depth << "-bit" << std::endl;

	std::vector<char> img(dataOffset - HEADER_SIZE);
	bmp.read(img.data(), img.size());

	auto dataSize = ((width * 3 + 3) & (~3)) * height;
	img.resize(dataSize);
	bmp.read(img.data(), img.size());

	char temp = 0;

	for (auto i = dataSize - 4; i >= 0; i -= 3)
	{
		temp = img[i];
		img[i] = img[i+2];
		img[i+2] = temp;

		std::cout << "[i=" << i << "] R: " << int(img[i] & 0xff) << " G: " << int(img[i+1] & 0xff) << " B: " << int(img[i+2] & 0xff) << std::endl;
	}

	return img;
}




unsigned char* ReadBMP(char* filename)
{
	int i;
	FILE* f = fopen(filename, "rb");

	if(f == NULL)
		throw "Argument Exception";

	unsigned char info[54];
	fread(info, sizeof(unsigned char), 54, f); // read the 54-byte header

	// extract image height and width from header
	int width = *(int*)&info[18];
	int height = *(int*)&info[22];
	
	std::cout << std::endl;
	std::cout << "  Name: " << filename << std::endl;
	std::cout << " Width: " << width << std::endl;
	std::cout << "Height: " << height << std::endl;
	
	int row_padded = (width*3 + 3) & (~3);
	unsigned char* data = new unsigned char[row_padded];
	unsigned char tmp;

	for(int i = 0; i < height; i++)
	{
		fread(data, sizeof(unsigned char), row_padded, f);
		for(int j = 0; j < width*3; j += 3)
		{
			// Convert (B, G, R) to (R, G, B)
			tmp = data[j];
			data[j] = data[j+2];
			data[j+2] = tmp;

			std::cout << "R: "<< (int)data[j] << " G: " << (int)data[j+1]<< " B: " << (int)data[j+2]<< std::endl;
		}
	}

	fclose(f);
	return data;
}


int main() {
	// load the file. The constructor now does most of the work
	char file_name[100] = {"Main_Icon_01system_focus.bmp"};
	BitMap example_bmp(file_name); 
	//readBMP(std::string(file_name));

	// get the vector <R,G,B> for the pixel at (1,1)
	std::vector<unsigned int> example_vector = example_bmp.getPixel(1,1); 
	example_bmp.convert24BitTo16Bit("Main_Icon_01system_focus_16bit.bmp");
}
