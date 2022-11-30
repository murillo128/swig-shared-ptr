%module swig_shared_ptr

%include "shared_ptr.i"

%{
#include <memory>

class Test
{
public:
	Test(bool boolean,int integer) :
		boolean(boolean),
		integer(integer)
	{
	}
	bool boolean;
	int  integer;

	int one() { return 1;}
	int inc(int a){ return a++;}
	int sum(int a,int b){ return a+b;}

};


%}

class Test
{
public:
	Test(bool boolean,int integer);
	bool boolean;
	int  integer;
	int one();
	int inc(int a);
	int sum(int a,int b);
};

SHARED_PTR(Test)
SHARED_PTR_ATTR_GETTER(Test,boolean,bool)
SHARED_PTR_ATTR_GETTER(Test,integer,int)
