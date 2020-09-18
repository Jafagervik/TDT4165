fun {ListLength L}
    case L of H | T then 
        1 + {ListLength T}
    else
        0
    end
end

fun {Take L Count} 
    if Count > {ListLength L} then
        L
    else 
        case L of H | T then
            if Count == 1 then 
                H | nil
            else
                H | {Take T Count-1}
            end 
        end
    end
end

fun {Drop L Count} 
    if Count > {ListLength L} then
        nil 
    else 
        case L of H | T then
            if Count == 1 then
                L
            else
                {Drop L Count-1}
            end
        end

    end
end

fun {Append L1 L2}
    if L1 == nil then 
        L2
    else 
        L1.1 | {Append L1.2 L2}
    end
end

fun {Member L Element}
    case L of H | T then
        if H == Element then
            true
        else
            {Member T Element}
        end
    else    
        false
    end
end

fun {Position L Element}
    case L of H | T then
        if H == Element then
            1
        else
            1 + {Position T element}
        end
    end
end