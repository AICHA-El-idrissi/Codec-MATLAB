function [compressionRatio, executionTime, encodedText] = huffmanCoding(text)
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
        
        prob = freq / sum(freq);
        symbolsCell = num2cell(double(symbols));
        dict = huffmandict(symbolsCell, prob);
        
        % Créer une map
        codeMap = containers.Map('KeyType', 'double', 'ValueType', 'any');
        for i = 1:size(dict, 1)
            codeMap(dict{i, 1}) = dict{i, 2};
        end
        
        % Calculer la taille RÉELLE de l'encodage
        totalBits = 0;
        for i = 1:length(text)
            if codeMap.isKey(double(text(i)))
                code = codeMap(double(text(i)));
                totalBits = totalBits + length(code);
            end
        end
        
        % Encoder pour affichage (limité)
        maxDisplay = min(1000, length(text));
        encodedText = '';
        for i = 1:maxDisplay
            if codeMap.isKey(double(text(i)))
                code = codeMap(double(text(i)));
                for k = 1:length(code)
                    encodedText = [encodedText num2str(code(k))];
                end
            end
        end
        
        if length(text) > maxDisplay
            encodedText = [encodedText '...(tronque)'];
        end
        
        % Calcul du taux de compression
        originalBits = length(text) * 8;
        compressionRatio = ((originalBits - totalBits) / originalBits) * 100;
        compressionRatio = max(0, compressionRatio);
        
    catch ME
        warning('Erreur Huffman: %s', ME.message);
        compressionRatio = 0;
        executionTime = toc;
        encodedText = sprintf('Erreur: %s', ME.message);
        return;
    end
    
    executionTime = toc;
end