function [compressionRatio, executionTime, encodedText] = shannonFanoCoding(text)
    tic;
    
    try
        if iscell(text)
            text = char(text);
        end
        
        if isempty(text)
            compressionRatio = 0;
            executionTime = toc;
            encodedText = '';
            return;
        end
        
        text = uint8(text);
        symbols = unique(text);
        
        if length(symbols) == 1
            compressionRatio = 0;
            executionTime = toc;
            encodedText = '0';
            return;
        end
        
        freq = zeros(size(symbols));
        for i = 1:length(symbols)
            freq(i) = sum(text == symbols(i));
        end
        
        [freq, idx] = sort(freq, 'descend');
        symbols = symbols(idx);
        prob = freq / sum(freq);
        
        % Créer les codes
        codes = cell(length(symbols), 1);
        codes = shannonFanoRecursive(prob, codes, 1, length(symbols), '');
        
        codeMap = containers.Map('KeyType', 'double', 'ValueType', 'any');
        for i = 1:length(symbols)
            codeMap(double(symbols(i))) = codes{i};
        end
        
        % Calculer la taille RÉELLE
        totalBits = 0;
        for i = 1:length(text)
            if codeMap.isKey(double(text(i)))
                totalBits = totalBits + length(codeMap(double(text(i))));
            end
        end
        
        % Encoder pour affichage
        maxDisplay = min(1000, length(text));
        encodedText = '';
        for i = 1:maxDisplay
            if codeMap.isKey(double(text(i)))
                encodedText = [encodedText codeMap(double(text(i)))];
            end
        end
        
        if length(text) > maxDisplay
            encodedText = [encodedText '...(tronque)'];
        end
        
        originalBits = length(text) * 8;
        compressionRatio = ((originalBits - totalBits) / originalBits) * 100;
        compressionRatio = max(0, min(100, compressionRatio));
        
    catch ME
        warning('Erreur Shannon-Fano: %s', ME.message);
        compressionRatio = 0;
        executionTime = toc;
        encodedText = sprintf('Erreur: %s', ME.message);
        return;
    end
    
    executionTime = toc;
end

function codes = shannonFanoRecursive(prob, codes, start, finish, prefix)
    if start == finish
        codes{start} = prefix;
        if isempty(prefix)
            codes{start} = '0';
        end
        return;
    end
    
    if start == finish - 1
        codes{start} = [prefix '0'];
        codes{finish} = [prefix '1'];
        return;
    end
    
    if start > finish || start < 1 || finish > length(codes)
        return;
    end
    
    totalProb = sum(prob(start:finish));
    if totalProb == 0
        totalProb = 1;
    end
    
    cumProb = 0;
    splitPoint = start;
    minDiff = inf;
    
    for i = start:finish-1
        cumProb = cumProb + prob(i);
        diff = abs(cumProb - (totalProb - cumProb));
        if diff < minDiff
            minDiff = diff;
            splitPoint = i;
        end
    end
    
    if splitPoint < start
        splitPoint = start;
    end
    if splitPoint >= finish
        splitPoint = finish - 1;
    end
    
    if start <= splitPoint
        codes = shannonFanoRecursive(prob, codes, start, splitPoint, [prefix '0']);
    end
    
    if splitPoint + 1 <= finish
        codes = shannonFanoRecursive(prob, codes, splitPoint + 1, finish, [prefix '1']);
    end
end