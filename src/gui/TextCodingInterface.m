function TextCodingInterface
    % Créer la figure principale
    fig = uifigure('Visible', 'off');
    fig.Position = [100 100 950 750];
    fig.Name = 'Codage de Texte';
    fig.Color = [0.94 0.96 0.98];
    
    % Panel principal avec ombre
    mainPanel = uipanel(fig);
    mainPanel.BackgroundColor = [1 1 1];
    mainPanel.Position = [15 15 920 720];
    
    % Header avec dégradé
    headerPanel = uipanel(mainPanel);
    headerPanel.BackgroundColor = [0.2 0.35 0.55];
    headerPanel.Position = [0 665 920 55];
    headerPanel.BorderType = 'none';
    
    % Logo
    logoImage = uiimage(headerPanel);
    logoImage.Position = [15 10 100 35];
    logoImage.ScaleMethod = 'fit';
    logoPath = fullfile(pwd, '..', '..', 'assets', 'images', 'ENSAFES_logo.png');
    if exist(logoPath, 'file')
        logoImage.ImageSource = logoPath;
    end
    
    % Titre
    titleLabel = uilabel(headerPanel);
    titleLabel.FontSize = 26;
    titleLabel.FontWeight = 'bold';
    titleLabel.FontColor = [1 1 1];
    titleLabel.HorizontalAlignment = 'center';
    titleLabel.Position = [250 10 420 35];
    titleLabel.Text = 'CODAGE DE TEXTE';
    
    % Zone de saisie
    textInputLabel = uilabel(mainPanel);
    textInputLabel.FontSize = 16;
    textInputLabel.FontWeight = 'bold';
    textInputLabel.FontColor = [0.2 0.35 0.55];
    textInputLabel.HorizontalAlignment = 'center';
    textInputLabel.Position = [250 620 420 25];
    textInputLabel.Text = 'Entrez votre texte ici :';
    
    textInputArea = uitextarea(mainPanel);
    textInputArea.Position = [40 560 840 55];
    textInputArea.FontSize = 14;
    textInputArea.BackgroundColor = [0.97 0.98 0.99];
    
    % Bouton encoder - Design moderne
    encodeButton = uibutton(mainPanel, 'push');
    encodeButton.BackgroundColor = [0.15 0.5 0.85];
    encodeButton.FontSize = 18;
    encodeButton.FontWeight = 'bold';
    encodeButton.FontColor = [1 1 1];
    encodeButton.Position = [360 500 200 45];
    encodeButton.Text = 'ANALYSER';
    
    % === LIGNE 1 : Huffman et Shannon-Fano ===
    
    % Huffman Panel
    huffmanPanel = uipanel(mainPanel);
    huffmanPanel.BackgroundColor = [0.95 0.97 1];
    huffmanPanel.Position = [25 370 430 110];
    
    huffmanLabel = uilabel(huffmanPanel);
    huffmanLabel.FontSize = 15;
    huffmanLabel.FontWeight = 'bold';
    huffmanLabel.FontColor = [0.2 0.35 0.55];
    huffmanLabel.HorizontalAlignment = 'center';
    huffmanLabel.Position = [10 82 410 25];
    huffmanLabel.Text = 'Algorithme de Huffman';
    
    huffmanResultArea = uitextarea(huffmanPanel);
    huffmanResultArea.Position = [10 10 410 68];
    huffmanResultArea.FontSize = 12;
    huffmanResultArea.Editable = 'off';
    huffmanResultArea.BackgroundColor = [1 1 1];
    
    % Shannon-Fano Panel
    shannonFanoPanel = uipanel(mainPanel);
    shannonFanoPanel.BackgroundColor = [0.95 0.97 1];
    shannonFanoPanel.Position = [465 370 430 110];
    
    shannonFanoLabel = uilabel(shannonFanoPanel);
    shannonFanoLabel.FontSize = 15;
    shannonFanoLabel.FontWeight = 'bold';
    shannonFanoLabel.FontColor = [0.2 0.35 0.55];
    shannonFanoLabel.HorizontalAlignment = 'center';
    shannonFanoLabel.Position = [10 82 410 25];
    shannonFanoLabel.Text = 'Algorithme de Shannon-Fano';
    
    shannonFanoResultArea = uitextarea(shannonFanoPanel);
    shannonFanoResultArea.Position = [10 10 410 68];
    shannonFanoResultArea.FontSize = 12;
    shannonFanoResultArea.Editable = 'off';
    shannonFanoResultArea.BackgroundColor = [1 1 1];
    
    % Comparaison 1
    comparison1Panel = uipanel(mainPanel);
    comparison1Panel.BackgroundColor = [0.98 0.98 0.98];
    comparison1Panel.Position = [25 305 870 55];
    
    comparison1Label = uilabel(comparison1Panel);
    comparison1Label.FontSize = 14;
    comparison1Label.FontWeight = 'bold';
    comparison1Label.FontColor = [0.3 0.3 0.3];
    comparison1Label.HorizontalAlignment = 'center';
    comparison1Label.Position = [10 5 850 45];
    comparison1Label.Text = 'Comparaison en cours...';
    
    % === LIGNE 2 : LZ et LZW ===
    
    % LZ Panel
    lzPanel = uipanel(mainPanel);
    lzPanel.BackgroundColor = [0.95 1 0.97];
    lzPanel.Position = [25 165 430 110];
    
    lzLabel = uilabel(lzPanel);
    lzLabel.FontSize = 15;
    lzLabel.FontWeight = 'bold';
    lzLabel.FontColor = [0.15 0.45 0.3];
    lzLabel.HorizontalAlignment = 'center';
    lzLabel.Position = [10 82 410 25];
    lzLabel.Text = 'Algorithme LZ77';
    
    lzResultArea = uitextarea(lzPanel);
    lzResultArea.Position = [10 10 410 68];
    lzResultArea.FontSize = 12;
    lzResultArea.Editable = 'off';
    lzResultArea.BackgroundColor = [1 1 1];
    
    % LZW Panel
    lzwPanel = uipanel(mainPanel);
    lzwPanel.BackgroundColor = [0.95 1 0.97];
    lzwPanel.Position = [465 165 430 110];
    
    lzwLabel = uilabel(lzwPanel);
    lzwLabel.FontSize = 15;
    lzwLabel.FontWeight = 'bold';
    lzwLabel.FontColor = [0.15 0.45 0.3];
    lzwLabel.HorizontalAlignment = 'center';
    lzwLabel.Position = [10 82 410 25];
    lzwLabel.Text = 'Algorithme LZW';
    
    lzwResultArea = uitextarea(lzwPanel);
    lzwResultArea.Position = [10 10 410 68];
    lzwResultArea.FontSize = 12;
    lzwResultArea.Editable = 'off';
    lzwResultArea.BackgroundColor = [1 1 1];
    
    % Comparaison 2
    comparison2Panel = uipanel(mainPanel);
    comparison2Panel.BackgroundColor = [0.98 0.98 0.98];
    comparison2Panel.Position = [25 100 870 55];
    
    comparison2Label = uilabel(comparison2Panel);
    comparison2Label.FontSize = 14;
    comparison2Label.FontWeight = 'bold';
    comparison2Label.FontColor = [0.3 0.3 0.3];
    comparison2Label.HorizontalAlignment = 'center';
    comparison2Label.Position = [10 5 850 45];
    comparison2Label.Text = 'Comparaison en cours...';
    
    % Footer
    footerLabel = uilabel(mainPanel);
    footerLabel.FontSize = 13;
    footerLabel.FontColor = [0.5 0.5 0.5];
    footerLabel.HorizontalAlignment = 'center';
    footerLabel.Position = [200 10 520 25];
    footerLabel.Text = 'ENSA Fes - Projet de Compression et Codage - 2eme Annee ISEIA';
    
    % Callback du bouton
    encodeButton.ButtonPushedFcn = @(~,~) encodeText();
    
    % Afficher la figure
    movegui(fig, 'center');
    fig.Visible = 'on';
    
    % Fonction de codage
    function encodeText()
        text = textInputArea.Value;
        
        if isempty(text) || (iscell(text) && isempty(text{1}))
            uialert(fig, 'Veuillez entrer un texte a coder.', 'Erreur');
            return;
        end
        
        if iscell(text)
            text = strjoin(text, ' ');
        end
        
        try
            utilsPath = fullfile(pwd, '..', 'utils');
            addpath(utilsPath);
            
            [huffRatio, huffTime, huffEncoded] = huffmanCoding(text);
            [sfRatio, sfTime, sfEncoded] = shannonFanoCoding(text);
            [lzRatio, lzTime, lzEncoded] = lzCoding(text);
            [lzwRatio, lzwTime, lzwEncoded] = lzwCoding(text);
            
            % Afficher Huffman
            huffText = sprintf('Taux de compression : %.2f%%\nTemps execution : %.4f s\nCode : %s', ...
                huffRatio, huffTime, truncateText(huffEncoded, 80));
            huffmanResultArea.Value = huffText;
            
            % Afficher Shannon-Fano
            sfText = sprintf('Taux de compression : %.2f%%\nTemps execution : %.4f s\nCode : %s', ...
                sfRatio, sfTime, truncateText(sfEncoded, 80));
            shannonFanoResultArea.Value = sfText;
            
            % Comparaison 1
            if abs(huffRatio - sfRatio) < 1
                comp1 = 'RESULTAT : Les deux algorithmes sont equivalents';
                comparison1Panel.BackgroundColor = [1 0.95 0.7];
                comparison1Label.FontColor = [0.6 0.4 0];
            elseif huffRatio > sfRatio
                comp1 = sprintf('RESULTAT : Huffman est meilleur (%.2f%% de gain)', huffRatio - sfRatio);
                comparison1Panel.BackgroundColor = [0.7 0.95 0.8];
                comparison1Label.FontColor = [0.1 0.5 0.2];
            else
                comp1 = sprintf('RESULTAT : Shannon-Fano est meilleur (%.2f%% de gain)', sfRatio - huffRatio);
                comparison1Panel.BackgroundColor = [0.75 0.9 1];
                comparison1Label.FontColor = [0.1 0.3 0.6];
            end
            comparison1Label.Text = comp1;
            
            % Afficher LZ
            lzText = sprintf('Taux de compression : %.2f%%\nTemps execution : %.4f s\nCode : %s', ...
                lzRatio, lzTime, truncateText(lzEncoded, 80));
            lzResultArea.Value = lzText;
            
            % Afficher LZW
            lzwText = sprintf('Taux de compression : %.2f%%\nTemps execution : %.4f s\nCode : %s', ...
                lzwRatio, lzwTime, truncateText(lzwEncoded, 80));
            lzwResultArea.Value = lzwText;
            
            % Comparaison 2
            if abs(lzwRatio - lzRatio) < 1
                comp2 = 'RESULTAT : Les deux algorithmes sont equivalents';
                comparison2Panel.BackgroundColor = [1 0.95 0.7];
                comparison2Label.FontColor = [0.6 0.4 0];
            elseif lzwRatio > lzRatio
                comp2 = sprintf('RESULTAT : LZW est meilleur (%.2f%% de gain)', lzwRatio - lzRatio);
                comparison2Panel.BackgroundColor = [0.7 0.95 0.8];
                comparison2Label.FontColor = [0.1 0.5 0.2];
            else
                comp2 = sprintf('RESULTAT : LZ77 est meilleur (%.2f%% de gain)', lzRatio - lzwRatio);
                comparison2Panel.BackgroundColor = [0.75 0.9 1];
                comparison2Label.FontColor = [0.1 0.3 0.6];
            end
            comparison2Label.Text = comp2;
            
        catch ME
            uialert(fig, sprintf('Erreur: %s', ME.message), 'Erreur');
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