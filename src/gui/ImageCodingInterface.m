function ImageCodingInterface
    % Créer la figure principale
    fig = uifigure('Visible', 'off');
    fig.Position = [100 100 1100 800];
    fig.Name = 'Codage d''Image';
    fig.Color = [0.94 0.96 0.98];
    fig.Scrollable = 'on';
    
    % Panel principal
    mainPanel = uipanel(fig);
    mainPanel.BackgroundColor = [1 1 1];
    mainPanel.Position = [15 15 1070 900];
    
    % Header
    headerPanel = uipanel(mainPanel);
    headerPanel.BackgroundColor = [0.25 0.5 0.35];
    headerPanel.Position = [0 845 1070 55];
    headerPanel.BorderType = 'none';
    
    % Titre
    titleLabel = uilabel(headerPanel);
    titleLabel.FontSize = 26;
    titleLabel.FontWeight = 'bold';
    titleLabel.FontColor = [1 1 1];
    titleLabel.HorizontalAlignment = 'center';
    titleLabel.Position = [250 10 570 35];
    titleLabel.Text = 'CODAGE ET COMPRESSION D''IMAGE';
    
    % Boutons
    loadButton = uibutton(mainPanel, 'push');
    loadButton.BackgroundColor = [0.2 0.6 0.4];
    loadButton.FontSize = 16;
    loadButton.FontWeight = 'bold';
    loadButton.FontColor = [1 1 1];
    loadButton.Position = [280 790 220 45];
    loadButton.Text = 'CHARGER IMAGE';
    
    processButton = uibutton(mainPanel, 'push');
    processButton.BackgroundColor = [0.15 0.5 0.85];
    processButton.FontSize = 16;
    processButton.FontWeight = 'bold';
    processButton.FontColor = [1 1 1];
    processButton.Position = [570 790 220 45];
    processButton.Text = 'ANALYSER';
    
    % Axes pour l'image
    imageAxes = uiaxes(mainPanel);
    imageAxes.Position = [50 550 970 220];
    imageAxes.XTick = [];
    imageAxes.YTick = [];
    imageAxes.Box = 'on';
    imageAxes.XColor = [0.7 0.7 0.7];
    imageAxes.YColor = [0.7 0.7 0.7];
    title(imageAxes, 'Aucune image chargee', 'FontSize', 14, 'Color', [0.5 0.5 0.5]);
    
    % === SECTION LECTURES ===
    
    readingsLabel = uilabel(mainPanel);
    readingsLabel.FontSize = 16;
    readingsLabel.FontWeight = 'bold';
    readingsLabel.FontColor = [0.2 0.35 0.55];
    readingsLabel.Position = [50 510 300 25];
    readingsLabel.Text = 'RESULTATS DES LECTURES';
    
    readingsArea = uitextarea(mainPanel);
    readingsArea.Position = [50 400 970 100];
    readingsArea.FontSize = 13;
    readingsArea.Editable = 'off';
    readingsArea.FontName = 'Consolas';
    readingsArea.BackgroundColor = [0.96 0.98 1];
    
    % Panel meilleure lecture
    bestReadingPanel = uipanel(mainPanel);
    bestReadingPanel.BackgroundColor = [0.98 0.98 0.98];
    bestReadingPanel.Position = [50 340 970 50];
    
    bestReadingLabel = uilabel(bestReadingPanel);
    bestReadingLabel.FontSize = 15;
    bestReadingLabel.FontWeight = 'bold';
    bestReadingLabel.FontColor = [0.3 0.3 0.3];
    bestReadingLabel.HorizontalAlignment = 'center';
    bestReadingLabel.Position = [10 10 950 30];
    bestReadingLabel.Text = '';
    
    % === SECTION COMPRESSION ===
    
    compressionLabel = uilabel(mainPanel);
    compressionLabel.FontSize = 16;
    compressionLabel.FontWeight = 'bold';
    compressionLabel.FontColor = [0.15 0.45 0.3];
    compressionLabel.Position = [50 300 400 25];
    compressionLabel.Text = 'COMPRESSION AVEC ALGORITHMES';
    
    % Panel Huffman
    huffmanPanel = uipanel(mainPanel);
    huffmanPanel.BackgroundColor = [0.95 0.97 1];
    huffmanPanel.Position = [50 195 490 90];
    
    huffmanLabel = uilabel(huffmanPanel);
    huffmanLabel.FontSize = 14;
    huffmanLabel.FontWeight = 'bold';
    huffmanLabel.FontColor = [0.2 0.35 0.55];
    huffmanLabel.HorizontalAlignment = 'center';
    huffmanLabel.Position = [10 62 470 25];
    huffmanLabel.Text = 'Huffman';
    
    huffmanResultArea = uitextarea(huffmanPanel);
    huffmanResultArea.Position = [10 10 470 48];
    huffmanResultArea.FontSize = 11;
    huffmanResultArea.Editable = 'off';
    huffmanResultArea.BackgroundColor = [1 1 1];
    
    % Panel Shannon-Fano
    shannonFanoPanel = uipanel(mainPanel);
    shannonFanoPanel.BackgroundColor = [0.95 0.97 1];
    shannonFanoPanel.Position = [560 195 490 90];
    
    shannonFanoLabel = uilabel(shannonFanoPanel);
    shannonFanoLabel.FontSize = 14;
    shannonFanoLabel.FontWeight = 'bold';
    shannonFanoLabel.FontColor = [0.2 0.35 0.55];
    shannonFanoLabel.HorizontalAlignment = 'center';
    shannonFanoLabel.Position = [10 62 470 25];
    shannonFanoLabel.Text = 'Shannon-Fano';
    
    shannonFanoResultArea = uitextarea(shannonFanoPanel);
    shannonFanoResultArea.Position = [10 10 470 48];
    shannonFanoResultArea.FontSize = 11;
    shannonFanoResultArea.Editable = 'off';
    shannonFanoResultArea.BackgroundColor = [1 1 1];
    
    % Panel LZ
    lzPanel = uipanel(mainPanel);
    lzPanel.BackgroundColor = [0.95 1 0.97];
    lzPanel.Position = [50 95 490 90];
    
    lzLabel = uilabel(lzPanel);
    lzLabel.FontSize = 14;
    lzLabel.FontWeight = 'bold';
    lzLabel.FontColor = [0.15 0.45 0.3];
    lzLabel.HorizontalAlignment = 'center';
    lzLabel.Position = [10 62 470 25];
    lzLabel.Text = 'LZ77';
    
    lzResultArea = uitextarea(lzPanel);
    lzResultArea.Position = [10 10 470 48];
    lzResultArea.FontSize = 11;
    lzResultArea.Editable = 'off';
    lzResultArea.BackgroundColor = [1 1 1];
    
    % Panel LZW
    lzwPanel = uipanel(mainPanel);
    lzwPanel.BackgroundColor = [0.95 1 0.97];
    lzwPanel.Position = [560 95 490 90];
    
    lzwLabel = uilabel(lzwPanel);
    lzwLabel.FontSize = 14;
    lzwLabel.FontWeight = 'bold';
    lzwLabel.FontColor = [0.15 0.45 0.3];
    lzwLabel.HorizontalAlignment = 'center';
    lzwLabel.Position = [10 62 470 25];
    lzwLabel.Text = 'LZW';
    
    lzwResultArea = uitextarea(lzwPanel);
    lzwResultArea.Position = [10 10 470 48];
    lzwResultArea.FontSize = 11;
    lzwResultArea.Editable = 'off';
    lzwResultArea.BackgroundColor = [1 1 1];
    
    % Panel meilleur algorithme
    bestAlgoPanel = uipanel(mainPanel);
    bestAlgoPanel.BackgroundColor = [0.98 0.98 0.98];
    bestAlgoPanel.Position = [50 35 1000 50];
    
    bestAlgoLabel = uilabel(bestAlgoPanel);
    bestAlgoLabel.FontSize = 16;
    bestAlgoLabel.FontWeight = 'bold';
    bestAlgoLabel.FontColor = [0.3 0.3 0.3];
    bestAlgoLabel.HorizontalAlignment = 'center';
    bestAlgoLabel.Position = [10 10 980 30];
    bestAlgoLabel.Text = '';
    
    % Variables
    loadedImage = [];
    processedImage = [];
    isColorImage = false;
    
    % Callbacks
    loadButton.ButtonPushedFcn = @(~,~) loadImage();
    processButton.ButtonPushedFcn = @(~,~) processImage();
    
    % Afficher
    movegui(fig, 'center');
    fig.Visible = 'on';
    
    function loadImage()
        [file, path] = uigetfile({'*.jpg;*.png;*.bmp;*.tif', 'Images (*.jpg,*.png,*.bmp,*.tif)'}, ...
            'Selectionnez une image');
        
        if isequal(file, 0)
            return;
        end
        
        try
            img = imread(fullfile(path, file));
            loadedImage = img;
            
            if size(img, 3) == 3
                isColorImage = true;
                processedImage = double(rgb2gray(img));
            else
                isColorImage = false;
                processedImage = double(img);
            end
            
            imshow(loadedImage, 'Parent', imageAxes);
            title(imageAxes, 'Image originale', 'FontSize', 14, 'Color', [0.2 0.35 0.55], 'FontWeight', 'bold');
            
            readingsArea.Value = sprintf('IMAGE CHARGEE\n\nDimensions : %dx%d pixels\nType : %s\nFichier : %s', ...
                size(img, 1), size(img, 2), ...
                ternary(isColorImage, 'Image couleur (RGB)', 'Niveaux de gris'), file);
            
            % Réinitialiser les résultats
            huffmanResultArea.Value = '';
            shannonFanoResultArea.Value = '';
            lzResultArea.Value = '';
            lzwResultArea.Value = '';
            bestReadingLabel.Text = '';
            bestAlgoLabel.Text = '';
            
        catch ME
            uialert(fig, sprintf('Erreur : %s', ME.message), 'Erreur');
        end
    end
    
    function processImage()
        if isempty(loadedImage)
            uialert(fig, 'Veuillez d''abord charger une image.', 'Erreur');
            return;
        end
        
        try
            utilsPath = fullfile(pwd, '..', 'utils');
            addpath(utilsPath);
            
            img = processedImage;
            [rows, cols] = size(img);
            
            notification = '';
            if rows ~= cols
                maxSize = max(rows, cols);
                newImg = zeros(maxSize, maxSize);
                newImg(1:rows, 1:cols) = img;
                img = newImg;
                notification = sprintf('IMAGE REDIMENSIONNEE : %dx%d --> %dx%d\n(Ajout de lignes/colonnes de zeros)\n\n', ...
                    rows, cols, maxSize, maxSize);
            end
            
            % === LECTURES ===
            vecH = readHorizontal(img);
            vecV = readVertical(img);
            vecZ = readZigzag(img);
            
            countH = maxZeroRun(vecH);
            countV = maxZeroRun(vecV);
            countZ = maxZeroRun(vecZ);
            
            [maxZeros, bestReadIdx] = max([countH, countV, countZ]);
            readingNames = {'Horizontale', 'Verticale', 'Zigzag'};
            
            readingsResults = sprintf(['%sRESULTATS DES LECTURES\n\n' ...
                '>> Lecture Horizontale : %d zeros successifs maximum\n' ...
                '>> Lecture Verticale   : %d zeros successifs maximum\n' ...
                '>> Lecture Zigzag      : %d zeros successifs maximum\n'], ...
                notification, countH, countV, countZ);
            
            readingsArea.Value = readingsResults;
            
            bestReadingLabel.Text = sprintf('MEILLEURE LECTURE : %s (%d zeros successifs)', ...
                readingNames{bestReadIdx}, maxZeros);
            bestReadingLabel.FontColor = [0.1 0.5 0.2];
            bestReadingPanel.BackgroundColor = [0.7 0.95 0.8];
            
            % === COMPRESSION ===
            % Utiliser la meilleure lecture pour la compression
            if bestReadIdx == 1
                dataToCompress = vecH;
            elseif bestReadIdx == 2
                dataToCompress = vecV;
            else
                dataToCompress = vecZ;
            end
            
            % Convertir en texte pour compression (échantillon)
            sampleSize = min(5000, length(dataToCompress));
            quantized = round(dataToCompress(1:sampleSize));
            quantized = max(0, min(255, quantized));
            textData = char(quantized);
            
            % Calculer les compressions
            [huffRatio, huffTime, huffEncoded] = huffmanCoding(textData);
            [sfRatio, sfTime, sfEncoded] = shannonFanoCoding(textData);
            [lzRatio, lzTime, lzEncoded] = lzCoding(textData);
            [lzwRatio, lzwTime, lzwEncoded] = lzwCoding(textData);
            
            % Afficher Huffman
            huffText = sprintf('Taux : %.2f%%\nTemps : %.4fs\nCode : %s', ...
                huffRatio, huffTime, truncateText(huffEncoded, 60));
            huffmanResultArea.Value = huffText;
            
            % Afficher Shannon-Fano
            sfText = sprintf('Taux : %.2f%%\nTemps : %.4fs\nCode : %s', ...
                sfRatio, sfTime, truncateText(sfEncoded, 60));
            shannonFanoResultArea.Value = sfText;
            
            % Afficher LZ
            lzText = sprintf('Taux : %.2f%%\nTemps : %.4fs\nCode : %s', ...
                lzRatio, lzTime, truncateText(lzEncoded, 60));
            lzResultArea.Value = lzText;
            
            % Afficher LZW
            lzwText = sprintf('Taux : %.2f%%\nTemps : %.4fs\nCode : %s', ...
                lzwRatio, lzwTime, truncateText(lzwEncoded, 60));
            lzwResultArea.Value = lzwText;
            
            % Meilleur algorithme
            [bestRatio, bestAlgoIdx] = max([huffRatio, sfRatio, lzRatio, lzwRatio]);
            algoNames = {'Huffman', 'Shannon-Fano', 'LZ77', 'LZW'};
            
            bestAlgoLabel.Text = sprintf('MEILLEUR ALGORITHME : %s (%.2f%% de compression) avec lecture %s', ...
                algoNames{bestAlgoIdx}, bestRatio, readingNames{bestReadIdx});
            bestAlgoLabel.FontColor = [0.1 0.5 0.2];
            bestAlgoPanel.BackgroundColor = [0.7 0.95 0.8];
            
            imshow(loadedImage, 'Parent', imageAxes);
            title(imageAxes, sprintf('Analyse terminee - %s + %s', readingNames{bestReadIdx}, algoNames{bestAlgoIdx}), ...
                'FontSize', 14, 'Color', [0.1 0.5 0.2], 'FontWeight', 'bold');
            
        catch ME
            uialert(fig, sprintf('Erreur : %s', ME.message), 'Erreur');
        end
    end
end

function maxRun = maxZeroRun(vec)
    maxRun = 0;
    currentRun = 0;
    for i = 1:length(vec)
        if vec(i) == 0
            currentRun = currentRun + 1;
            maxRun = max(maxRun, currentRun);
        else
            currentRun = 0;
        end
    end
end

function truncated = truncateText(text, maxLength)
    if length(text) > maxLength
        truncated = [text(1:maxLength) '...'];
    else
        truncated = text;
    end
end

function result = ternary(condition, trueVal, falseVal)
    if condition
        result = trueVal;
    else
        result = falseVal;
    end
end