function [compressionRatio, executionTime, encodedText] = lzwCoding(text)
    tic;
    
    if iscell(text)
        text = char(text);
    end
    
    % Initialiser dictionnaire
    symbols = unique(text);
    dict = containers.Map('KeyType', 'char', 'ValueType', 'double');
    
    for i = 1:length(symbols)
        dict(symbols(i)) = i;
    end
    
    nextCode = length(symbols) + 1;
    w = '';
    compressed = [];
    
    for i = 1:length(text)
        c = text(i);
        wc = [w c];
        
        if isKey(dict, wc)
            w = wc;
        else
            if ~isempty(w)
                compressed = [compressed dict(w)];
            end
            dict(wc) = nextCode;
            nextCode = nextCode + 1;
            w = c;
        end
    end
    
    if ~isempty(w)
        compressed = [compressed dict(w)];
    end
    
    % Créer texte encodé (limité)
    encodedText = '';
    for i = 1:min(100, length(compressed))
        encodedText = [encodedText sprintf('%d ', compressed(i))];
    end
    if length(compressed) > 100
        encodedText = [encodedText '...'];
    end
    encodedText = strtrim(encodedText);
    
    % Calculer bits nécessaires dynamiquement
    maxCode = max(compressed);
    bitsPerCode = ceil(log2(maxCode + 1));  % Bits réels nécessaires
    
    originalBits = length(text) * 8;
    compressedBits = length(compressed) * bitsPerCode;
    
    compressionRatio = ((originalBits - compressedBits) / originalBits) * 100;
    compressionRatio = max(0, compressionRatio);
    
    executionTime = toc;
end