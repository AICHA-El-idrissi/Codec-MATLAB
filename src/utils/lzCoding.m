function [compressionRatio, executionTime, encodedText] = lzCoding(text)
    tic;
    
    if iscell(text)
        text = char(text);
    end
    
    windowSize = 4096;
    lookaheadSize = 18;
    
    compressed = [];
    i = 1;
    n = length(text);
    
    while i <= n
        matchLength = 0;
        matchDistance = 0;
        
        searchStart = max(1, i - windowSize);
        
        for j = searchStart:(i-1)
            k = 0;
            while (i + k <= n) && (k < lookaheadSize) && (text(j + k) == text(i + k))
                k = k + 1;
            end
            
            if k > matchLength
                matchLength = k;
                matchDistance = i - j;
            end
        end
        
        if matchLength > 0
            compressed = [compressed; matchDistance, matchLength, double(text(min(i + matchLength, n)))];
            i = i + matchLength + 1;
        else
            compressed = [compressed; 0, 0, double(text(i))];
            i = i + 1;
        end
    end
    
    % Créer texte encodé
    encodedText = '';
    for i = 1:min(50, size(compressed, 1))  % Limiter l'affichage
        encodedText = [encodedText sprintf('(%d,%d,%c) ', compressed(i,1), compressed(i,2), char(compressed(i,3)))];
    end
    if size(compressed, 1) > 50
        encodedText = [encodedText '...'];
    end
    encodedText = strtrim(encodedText);
    
    %  Calcul réaliste de la taille
    % Distance: 12 bits (jusqu'à 4096)
    % Longueur: 5 bits (jusqu'à 18)
    % Caractère: 8 bits
    % Total: 25 bits par triplet (pas 16!)
    originalBits = length(text) * 8;
    compressedBits = size(compressed, 1) * 25;
    
    compressionRatio = ((originalBits - compressedBits) / originalBits) * 100;
    compressionRatio = max(0, compressionRatio);
    
    executionTime = toc;
end