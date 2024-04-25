// The fundamental of E are those things which every E compiler must support in order to be spec complient.
// These are core features which are defined by being indivisible into smaller sub-routines or functions.
// A good example of this is loops. Foreach loops can be made from for loops. For loops can be made from while loops. While loops can be made from jump not equal statements.
// Therefore only jump not equal statements are considered fundamental building blocks.

#defproc WhileLoop
#endef
 while(predicate){body}; where predicate bool,