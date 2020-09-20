functor
import 
    System
    Application(exit:Exit)
    Module
define
    \insert list.oz
    \insert mdc.oz
    %Browse = System.showInfo

    {System.showInfo {Lex "1 2 + 3 *"} }
    {Exit 0}
end