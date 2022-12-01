%module swig_shared_ptr

%include "shared_ptr.i"

%{
#include <memory>

class Test;
class Base
{
public:
	int  base = 3;
	bool CheckShared(const std::shared_ptr<Base>& shared)
	{
		 return true;
	}
};

class Test : public Base
{
public:
	Test(bool boolean,int integer) :
		boolean(boolean),
		integer(integer)
	{
	}
	bool boolean;
	int  integer;
	const int  readonly = 7;

	int one() { return 1;}
	int inc(int a){ return a++;}
	int sum(int a,int b){ return a+b;}
};

%}


class Base
{
public:
	int  base = 3;
	bool CheckShared(const std::shared_ptr<Base>& shared);
};
SHARED_PTR(Base)


class Test : public Base
{
public:
	Test(bool boolean,int integer);
	bool boolean;
	int  integer;
	const int readonly = 7;

	int one();
	int inc(int a);
	int sum(int a,int b);

};

SHARED_PTR_BEGIN(Test)
{
	Test_shared_ptr(bool boolean,int integer) 
	{
		return new std::shared_ptr<Test>(new Test(boolean,integer));
	}
	SHARED_PTR_TO(Base)
}
SHARED_PTR_END(Test)


/*
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
SHARED_PTR_END(Test)

SHARED_PTR_ATTR_RO(Test,readonly,int)
SHARED_PTR_ATTR(Test,boolean,bool)
SHARED_PTR_ATTR(Test,integer,int)
*/



