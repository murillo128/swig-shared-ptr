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
	int  readonly = 7;

	int one() { return 1;}
	int inc(int a){ return a++;}
	int sum(int a,int b){ return a+b;}

};


%}

SHARED_PTR_BEGIN(Test)
{
	Test_shared_ptr(bool boolean,int integer) 
	{
		return new std::shared_ptr<Test>(new Test(boolean,integer));
	}
	int one()		{ return (*self)->one();}
	int inc(int a)		{ return (*self)->inc(a);}
	int sum(int a,int b)	{ return (*self)->sum(a,b);}

}
SHARED_PTR_END()

SHARED_PTR_ATTR_RO(Test,readonly,int)
SHARED_PTR_ATTR(Test,boolean,bool)
SHARED_PTR_ATTR(Test,integer,int)




