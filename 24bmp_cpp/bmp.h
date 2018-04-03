#ifndef BMP_H
#define BMP_H

#include <iostream>
#include <vector>
#include <fstream>


#pragma pack(push, 1)                // 구조체를 1바이트 크기로 정렬

typedef struct _BITMAPFILEHEADER     // BMP 비트맵 파일 헤더 구조체
{
	unsigned short bfType;           // BMP 파일 매직 넘버
	unsigned int   bfSize;           // 파일 크기
	unsigned short bfReserved1;      // 예약
	unsigned short bfReserved2;      // 예약
	unsigned int   bfOffBits;        // 비트맵 데이터의 시작 위치
} BITMAPFILEHEADER;

typedef struct _BITMAPINFOHEADER     // BMP 비트맵 정보 헤더 구조체(DIB 헤더)
{
	unsigned int   biSize;           // 현재 구조체의 크기
	int            biWidth;          // 비트맵 이미지의 가로 크기
	int            biHeight;         // 비트맵 이미지의 세로 크기
	unsigned short biPlanes;         // 사용하는 색상판의 수
	unsigned short biBitCount;       // 픽셀 하나를 표현하는 비트 수
	unsigned int   biCompression;    // 압축 방식
	unsigned int   biSizeImage;      // 비트맵 이미지의 픽셀 데이터 크기
	int            biXPelsPerMeter;  // 그림의 가로 해상도(미터당 픽셀)
	int            biYPelsPerMeter;  // 그림의 세로 해상도(미터당 픽셀)
	unsigned int   biClrUsed;        // 색상 테이블에서 실제 사용되는 색상 수
	unsigned int   biClrImportant;   // 비트맵을 표현하기 위해 필요한 색상 인덱스 수
} BITMAPINFOHEADER;

typedef struct _RGBTRIPLE            // 24비트 비트맵 이미지의 픽셀 구조체
{
	unsigned char rgbtBlue;          // 파랑
	unsigned char rgbtGreen;         // 초록
	unsigned char rgbtRed;           // 빨강
} RGBTRIPLE;

#pragma pack(pop)

class BitMap {

	private:
		unsigned char m_bmpFileHeader[14];
		unsigned int m_pixelArrayOffset;
		unsigned char m_bmpInfoHeader[40];

		int m_height;
		int m_width;
		int m_bitsPerPixel;

		int m_rowSize;
		int m_pixelArraySize;

		unsigned char* m_pixelData;

		char * m_copyname;
		const char * m_filename;
	public:
		BitMap(const char * filename);
		~BitMap();

		std::vector<unsigned int> getPixel(int i,int j);

		void makeCopy(char * filename);
		void makeHeader(char* filename);
		void changeHeader(char* filename, int offset, char value);
		void attachRawData(char* filename);
		void convert24BitTo16Bit(char * filename);
		void writePixel(int i,int j, int R, int G, int B);
		void writePixel(char * filename, int x,int y, unsigned int pixel16);

		void swapPixel(int i, int j, int i2, int j2);

		void dispPixelData();

		int width() {return m_width;}
		int height() {return m_height;}

		int vd(int i, int j);
		int hd(int i, int j);

		bool isSorted();
};

BitMap::BitMap( const char * filename) {

	using namespace std;

	m_filename = filename;

	ifstream inf(filename);
	if(!inf) {
		std::cerr<<"Unable to open file: "<<filename<<"\n";
	}

	unsigned char m_bmpFileHeader[14];
	unsigned char a;
	for(int i =0;i<14;i++) {
		inf>>hex>>a;
		m_bmpFileHeader[i] = a;
	}
	if(m_bmpFileHeader[0]!='B' || m_bmpFileHeader[1]!='M') {
		std::cerr<<"Your info header might be different!\nIt should start with 'BM'.\n";
	}
	
	/* THE FOLLOWING LINE ONLY WORKS IF THE OFFSET IS 1 BYTE!!!!!  (it can be 4 bytes max) That should be fixed now.
	 * old line was m_pixelArrayOffset = m_bmpFileHeader[10];
	 */
	unsigned int * array_offset_ptr = (unsigned int *)(m_bmpFileHeader + 10);
	m_pixelArrayOffset = *array_offset_ptr;
	
	if( m_bmpFileHeader[11] != 0 || m_bmpFileHeader[12] !=0 || m_bmpFileHeader[13] !=0)
	{
		std::cerr<< "You probably need to fix something.  bmp.h("<<__LINE__<<")\n";
	}
	
	for(int i=0;i<40;i++)
	{
		inf>>hex>>a;
		m_bmpInfoHeader[i]=a;
	}
	
	int * width_ptr = (int*)(m_bmpInfoHeader+4);
	int * height_ptr = (int*)(m_bmpInfoHeader+8);
	
	m_width = *width_ptr;
	m_height = *height_ptr;
	
	printf("W: %i, H: %i\n", m_width, m_height);
	
	m_bitsPerPixel = m_bmpInfoHeader[14];
	if(m_bitsPerPixel!=24)
	{
		std::cerr<<"This program is for 24bpp files.  Your bmp is not that\n";
	}

	int compressionMethod = m_bmpInfoHeader[16];
	if(compressionMethod!=0)
	{
		cerr<<"There's some compression stuff going on that we might not be able to deal with.\n";
		cerr<<"Comment out offending lines to continue anyways.  bpm.h line: "<<__LINE__<<"\n";
	}
	

	m_rowSize = int( float( (m_bitsPerPixel*m_width + 31.)/32)) *4;
	m_pixelArraySize = m_rowSize* abs(m_height);
	std::cout << "data size : " << m_pixelArraySize << std::endl;
	m_pixelData = new unsigned char [m_pixelArraySize];

	inf.seekg(m_pixelArrayOffset,ios::beg);
	for(int i=0;i<m_pixelArraySize;i++)
	{
		inf>>hex>>a;
		m_pixelData[i]=a; 
	}
}
	
BitMap::~BitMap()
{
	delete[] m_pixelData;
}

void BitMap::dispPixelData()
{
	for(int i=0;i<m_pixelArraySize;i++)
	{
		std::cout<<(unsigned int)m_pixelData[i]<<" ";   
		if (i % 0x10)	std::cout << std::endl;
	}
	std::cout<<"\n";
}
	
// output is in rgb order.
std::vector<unsigned int> BitMap::getPixel(int x, int y)
{
	if(x<m_width && y<m_height)
	{
		std::vector<unsigned int> v;
		v.push_back(0);
		v.push_back(0);
		v.push_back(0);

		y = m_height -1- y; //to flip things
		//std::cout<<"y: "<<y<<" x: "<<x<<"\n";
		v[0] = (unsigned int) ( m_pixelData[ m_rowSize*y+3*x+2 ]);
		//red
		v[1] = (unsigned int) ( m_pixelData[ m_rowSize*y+3*x+1 ]);
		//greed
		v[2] = (unsigned int) ( m_pixelData[ m_rowSize*y+3*x+0 ]);
		//blue
		return v;
	}
	else
	{
		std::cerr<<"BAD INDEX\n";std::cerr<<"X: "<<x<<" Y: "<<y<<"\n";
	}
}

void BitMap::makeCopy(char* filename)
{
	std::ofstream copyfile(filename);
	std::ifstream inf(m_filename);
	char ch;
	m_copyname = filename;

	while(inf) {
		ch = inf.get();
		copyfile.put(ch);
	}

	inf.close();
	copyfile.close();
}

enum {
	RED = 0,
	GREEN,
	BLUE,
};

void BitMap::changeHeader(char* filename, int offset, char value)
{
	std::ofstream copyfile(filename);
	std::ifstream inf(m_filename);
	char ch;
	int i = 0;

	while (i < 55) {
		i++;
		if (i == offset) {
			//ch = value;
			//ch = inf.get();
			printf("[%d]0x%x\n", i, ch);
		}
		else {
			ch = inf.get();
		}
		copyfile.put(ch);
	}

	inf.close();
	copyfile.close();
}

void BitMap::makeHeader(char* filename)
{
	std::ofstream copyfile(filename);
	std::ifstream inf(m_filename);
	char ch;
	int i = 0;
	m_copyname = filename;

	while (i < 55) {
		i++;
		ch = inf.get();
		copyfile.put(ch);
	}

	inf.close();
	copyfile.close();
}

void BitMap::attachRawData(char* filename)
{
	std::ofstream of;
	of.open(filename, std::ios_base::app);
	std::ifstream inf(m_filename);
	char ch;
	inf.seekg(55, std::ios_base::beg);

	while (inf) {
		ch = inf.get();
		of.put(ch);
	}

	inf.close();
	of.close();
}

void BitMap::convert24BitTo16Bit(char * filename)
{
	//makeCopy(filename);
	//makeHeader(filename);
	changeHeader(filename, 29, 16);
	//attachRawData(filename);

	std::ofstream of;
	of.open(filename, std::ios_base::app);

	std::vector<unsigned int> v;
	unsigned char red;
	unsigned char green;
	unsigned char blue;
	unsigned int pixel16;
	int x = 0;
	int y = 0;

	for (int i = 0;i < m_pixelArraySize;i++) {
		//std::cout << "x : " << x << "; y : " << y << " (" << i << ")" << std::endl;
		x = i % m_rowSize;
		y = i / m_rowSize;
		v = getPixel(x, y);
		// red 0; green 1; blue 2;
		red = v[RED] >> 3;
		green = v[GREEN] >> 3;
		blue = v[BLUE] >> 3;
		pixel16 = 0x7fff & (red | green << 5 | blue << 10);
		writePixel(filename, x, y, pixel16);
	}

	of.close();
}

void BitMap::writePixel(char * filename, int x,int y, unsigned int pixel16)
{
	std::fstream file(filename);
	y = m_height -1- y;
	// to flip things.
	int blueOffset = m_pixelArrayOffset + m_rowSize * y + 2 * x;

	// writes to the file
	file.seekg(blueOffset,std::ios::beg);
	file<< (unsigned char)(pixel16 >> 8);
	file.seekg(blueOffset+1,std::ios::beg);
	file<< (unsigned char)(pixel16 & 0xff);

	// edits data in pixelData array 
	m_pixelData[m_rowSize*y+2*x+1] = (unsigned char)(pixel16 >> 8);
	m_pixelData[m_rowSize*y+2*x+0] = (unsigned char)(pixel16 & 0xff);

	file.close();
}

// changes the file
void BitMap::writePixel(int x,int y, int R, int G, int B)
{
	std::fstream file(m_filename);
	y = m_height -1- y;
	// to flip things.
	int blueOffset = m_pixelArrayOffset+m_rowSize*y+3*x+0;

	// writes to the file
	file.seekg(blueOffset,std::ios::beg);
	file<< (unsigned char)B;
	file.seekg(blueOffset+1,std::ios::beg);
	file<< (unsigned char)G;
	file.seekg(blueOffset+2,std::ios::beg);
	file<< (unsigned char)R;

	// edits data in pixelData array 
	m_pixelData[m_rowSize*y+3*x+2] = (unsigned char)R;
	m_pixelData[m_rowSize*y+3*x+1] = (unsigned char)G;
	m_pixelData[m_rowSize*y+3*x+0] = (unsigned char)B;
}
	
// changes the file
void BitMap::swapPixel(int i, int j, int i2, int j2)
{
	std::vector<unsigned int> p1 = (*this).getPixel(i,j);
	
	std::vector<unsigned int> p2 = (*this).getPixel(i2,j2);

	(*this).writePixel(i,j,p2[0],p2[1],p2[2]);
	(*this).writePixel(i2,j2,p1[0],p1[1],p1[2]);

}
#endif	/* BMP_H */
