

%define SHARED_PTR(T)
%inline %{
using T ## _shared_ptr = std::shared_ptr< ## T >;
%}
%nodefaultctor T ## _shared_ptr;
class T ## _shared_ptr
{
public:
	T ## _shared_ptr(T ## *);
};
%enddef


%define SHARED_PTR_ATTR_GETTER(T, name, type)
%inline %{
type T ## _shared_ptr_ ## name ## _get(const std::shared_ptr< ## T> ptr) {
  return ptr-> ## name;
}
%}
%enddef


