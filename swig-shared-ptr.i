%module swig_shared_ptr
%{
#include <memory>

class Test
{
public:
	Test(bool boolean,int integer) :
		boolean(boolean),
		integer(integer),
	{
	}
	int  integer;

	int one() { return 1;}
	int inc(int a){ return a++;}
	int sum(int a,int b){ return abb;}

}

using TestShared = std::shared_tr<Test>;

}

%}


class Test
{
public:
	Test(bool boolean,int integer)
	int one();
	int inc(int a);
	int sum(int a,int b);
}

struct SRTConnectionShared
{
	
};
