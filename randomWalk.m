function out = randomWalk(N, P, s, w, e)
row=99;
col=99;
hist = zeros(1,N);
results = zeros(1,col);

for i = 1:N
    %set start location for 1 particle
    currentRow = 1;
    if(P == 'rand')
        currentCol = randi(99);
    else
        currentCol = 50;
    end
    
    
    while currentRow <= row
            r = rand();
            if(r < s)
                if(currentRow  ~= row - results(currentCol)&&currentRow~=row)
                    currentRow = currentRow + 1;
                else
                    results(currentCol) = results(currentCol) + 1;
                    hist(i) = currentCol;
                    break
                end
            elseif(r>s && r<s+w)
                if(currentCol==1)
                    if(currentRow ~= row - results(col))
                        currentCol = col;
                    end
                else
                    if(currentRow ~= row - results(currentCol-1))
                        currentCol = currentCol - 1;
                    end
                end
            else
               if(currentCol==col)
                   if(currentRow ~= row - results(1))
                       currentCol = 1;
                   end
               else
                   if(currentRow ~= row - results(currentCol+1))
                        currentCol = currentCol + 1;
                   end
               end
            end
    end
end
edges = [0:1:99];
out = histogram(hist,edges);
title("N = "+N+", P = "+P)
xlabel('X Position')
ylabel('Y Position')
end