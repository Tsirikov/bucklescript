


function fromString(i) do
  i$1 = parseFloat(i);
  if (isNaN(i$1)) then do
    return ;
  end else do
    return i$1;
  end end 
end end

export do
  fromString ,
  
end
--[[ No side effect ]]