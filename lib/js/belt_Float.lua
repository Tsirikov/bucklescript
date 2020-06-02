--[['use strict';]]


function fromString(i) do
  i$1 = parseFloat(i);
  if (isNaN(i$1)) then do
    return ;
  end else do
    return i$1;
  end end 
end end

exports.fromString = fromString;
--[[ No side effect ]]