classdef AudioCodingInterface < matlab.apps.AppBase

    properties (Access = public)
        UIFigure matlab.ui.Figure
        MainPanel matlab.ui.container.Panel
        TitleLabel matlab.ui.control.Label
        
        LoadButton matlab.ui.control.Button
        PlayButton matlab.ui.control.Button
        PlayCompressedButton matlab.ui.control.Button
        ProcessButton matlab.ui.control.Button
        SaveButton matlab.ui.control.Button
        
        OriginalAxes matlab.ui.control.UIAxes
        CompressedAxes matlab.ui.control.UIAxes
        
        ResultsArea matlab.ui.control.TextArea
        EncodedArea matlab.ui.control.TextArea
        
        BestAlgoLabel matlab.ui.control.Label
        
        LoadedAudio
        CompressedAudio
        SampleRate
        AudioPlayer
        CompressedPlayer
        BestAlgorithm
    end

    methods (Access = private)
        function startupFcn(app)
            movegui(app.UIFigure, 'center');
        end

        function LoadButtonPushed(app, ~)
            [file, path] = uigetfile({'*.wav;*.mp3;*.m4a;*.flac', 'Fichiers Audio (*.wav,*.mp3,*.m4a,*.flac)'}, ...
                'Sélectionnez un fichier audio');
            
            if isequal(file, 0)
                return;
            end
            
            try
                % Charger l'audio
                [y, fs] = audioread(fullfile(path, file));
                
                % Si stéréo, convertir en mono
                if size(y, 2) == 2
                    y = mean(y, 2);
                end
                
                app.LoadedAudio = y;
                app.SampleRate = fs;
                
                % Afficher le signal audio original
                t = (0:length(y)-1) / fs;
                plot(app.OriginalAxes, t, y, 'b', 'LineWidth', 1);
                title(app.OriginalAxes, 'Signal Audio Original', 'FontSize', 12, 'FontWeight', 'bold');
                xlabel(app.OriginalAxes, 'Temps (s)');
                ylabel(app.OriginalAxes, 'Amplitude');
                grid(app.OriginalAxes, 'on');
                
                % Info sur l'audio
                fileSizeKB = length(y) * 2 / 1024; % 16-bit audio
                app.ResultsArea.Value = sprintf(['📂 FICHIER CHARGÉ\n\n' ...
                    '• Nom: %s\n' ...
                    '• Durée: %.2f secondes\n' ...
                    '• Fréquence: %d Hz\n' ...
                    '• Échantillons: %d\n' ...
                    '• Taille: %.2f KB'], ...
                    file, length(y)/fs, fs, length(y), fileSizeKB);
                
                % Créer le player audio
                app.AudioPlayer = audioplayer(y, fs);
                
                % Réinitialiser l'affichage compressé
                cla(app.CompressedAxes);
                title(app.CompressedAxes, 'Signal Audio Compressé (après traitement)', 'FontSize', 12);
                app.EncodedArea.Value = '';
                app.BestAlgoLabel.Text = '';
                
            catch ME
                uialert(app.UIFigure, sprintf('Erreur: %s', ME.message), 'Erreur', 'Icon', 'error');
            end
        end

        function PlayButtonPushed(app, ~)
            if isempty(app.LoadedAudio)
                uialert(app.UIFigure, 'Veuillez d''abord charger un fichier audio.', 'Erreur', 'Icon', 'error');
                return;
            end
            
            try
                if ~isempty(app.AudioPlayer) && isvalid(app.AudioPlayer)
                    if isplaying(app.AudioPlayer)
                        stop(app.AudioPlayer);
                        app.PlayButton.Text = '▶ JOUER ORIGINAL';
                    else
                        play(app.AudioPlayer);
                        app.PlayButton.Text = '⏸ PAUSE';
                    end
                end
            catch ME
                uialert(app.UIFigure, sprintf('Erreur: %s', ME.message), 'Erreur', 'Icon', 'error');
            end
        end
        
        function PlayCompressedButtonPushed(app, ~)
            if isempty(app.CompressedAudio)
                uialert(app.UIFigure, 'Veuillez d''abord traiter l''audio.', 'Erreur', 'Icon', 'error');
                return;
            end
            
            try
                if ~isempty(app.CompressedPlayer) && isvalid(app.CompressedPlayer)
                    if isplaying(app.CompressedPlayer)
                        stop(app.CompressedPlayer);
                        app.PlayCompressedButton.Text = '▶ JOUER COMPRESSÉ';
                    else
                        play(app.CompressedPlayer);
                        app.PlayCompressedButton.Text = '⏸ PAUSE';
                    end
                end
            catch ME
                uialert(app.UIFigure, sprintf('Erreur: %s', ME.message), 'Erreur', 'Icon', 'error');
            end
        end

        function ProcessButtonPushed(app, ~)
            if isempty(app.LoadedAudio)
                uialert(app.UIFigure, 'Veuillez d''abord charger un fichier audio.', 'Erreur', 'Icon', 'error');
                return;
            end
            
            try
                % Ajouter le chemin des utils
                utilsPath = fullfile(pwd, '..', 'utils');
                addpath(utilsPath);
                
                % Convertir l'audio en données quantifiées
                audioData = app.LoadedAudio;
                
                % Quantifier sur 8 bits
                quantized = round((audioData + 1) * 127.5);
                quantized = max(0, min(255, quantized));
                
                % Prendre un échantillon pour le codage
                sampleSize = min(10000, length(quantized));
                textData = char(quantized(1:sampleSize));
                
                % Calculer les compressions
                [huffRatio, huffTime, huffEncoded] = huffmanCoding(textData);
                [sfRatio, sfTime, sfEncoded] = shannonFanoCoding(textData);
                [lzRatio, lzTime, lzEncoded] = lzCoding(textData);
                [lzwRatio, lzwTime, lzwEncoded] = lzwCoding(textData);
                
                % Déterminer le meilleur algorithme
                [bestRatio, bestIdx] = max([huffRatio, sfRatio, lzRatio, lzwRatio]);
                algoNames = {'Huffman', 'Shannon-Fano', 'LZ77', 'LZW'};
                app.BestAlgorithm = algoNames{bestIdx};
                
                % Calculer les tailles
                originalSize = length(audioData) * 16 / 8 / 1024; % KB
                compressedSize = originalSize * (1 - bestRatio/100);
                
                % Simuler l'audio compressé (réduction de résolution)
                compressionFactor = 1 - bestRatio/100;
                downsampleFactor = max(1, round(1/compressionFactor));
                app.CompressedAudio = resample(audioData, 1, downsampleFactor);
                
                % Afficher le signal compressé
                t_compressed = (0:length(app.CompressedAudio)-1) / (app.SampleRate/downsampleFactor);
                plot(app.CompressedAxes, t_compressed, app.CompressedAudio, 'r', 'LineWidth', 1);
                title(app.CompressedAxes, sprintf('Signal Compressé - %s', app.BestAlgorithm), ...
                    'FontSize', 12, 'FontWeight', 'bold', 'Color', [0.8 0.2 0.2]);
                xlabel(app.CompressedAxes, 'Temps (s)');
                ylabel(app.CompressedAxes, 'Amplitude');
                grid(app.CompressedAxes, 'on');
                
                % Créer le player pour l'audio compressé
                app.CompressedPlayer = audioplayer(app.CompressedAudio, app.SampleRate/downsampleFactor);
                
                % Afficher les résultats
                results = sprintf([' RÉSULTATS DE COMPRESSION AUDIO\n\n' ...
                    'TAUX DE COMPRESSION:\n' ...
                    '1 Huffman: %.2f%% (%.4fs)\n' ...
                    '2 Shannon-Fano: %.2f%% (%.4fs)\n' ...
                    '3 LZ77: %.2f%% (%.4fs)\n' ...
                    '4 LZW: %.2f%% (%.4fs)\n\n' ...
                    ' TAILLES:\n' ...
                    '• Original: %.2f KB\n' ...
                    '• Compressé: %.2f KB\n' ...
                    '• Gain: %.2f KB (%.1f%%)\n\n' ...
                    ' Note: Test sur %d échantillons'], ...
                    huffRatio, huffTime, sfRatio, sfTime, ...
                    lzRatio, lzTime, lzwRatio, lzwTime, ...
                    originalSize, compressedSize, originalSize - compressedSize, bestRatio, sampleSize);
                
                app.ResultsArea.Value = results;
                
                % Afficher les données codées
                encodedDisplay = sprintf(['═════════════════════════════════\n' ...
                    ' DONNÉES CODÉES (premiers 500 caractères)\n' ...
                    '═════════════════════════════════\n\n' ...
                    ' HUFFMAN:\n%s\n\n' ...
                    ' SHANNON-FANO:\n%s\n\n' ...
                    ' LZ77:\n%s\n\n' ...
                    ' LZW:\n%s\n'], ...
                    truncateText(huffEncoded, 500), ...
                    truncateText(sfEncoded, 500), ...
                    truncateText(lzEncoded, 500), ...
                    truncateText(lzwEncoded, 500));
                
                app.EncodedArea.Value = encodedDisplay;
                
                % Afficher le meilleur algorithme
                app.BestAlgoLabel.Text = sprintf(' Meilleur algorithme: %s (%.2f%% de compression)', ...
                    app.BestAlgorithm, bestRatio);
                app.BestAlgoLabel.FontColor = [0 0.6 0.2];
                
            catch ME
                uialert(app.UIFigure, sprintf('Erreur: %s', ME.message), 'Erreur', 'Icon', 'error');
            end
        end
        
        function SaveButtonPushed(app, ~)
            if isempty(app.CompressedAudio)
                uialert(app.UIFigure, 'Veuillez d''abord traiter l''audio.', 'Erreur', 'Icon', 'error');
                return;
            end
            
            try
                [file, path] = uiputfile('*.wav', 'Enregistrer l''audio compressé');
                if isequal(file, 0)
                    return;
                end
                
                % Normaliser l'audio compressé
                normalized = app.CompressedAudio / max(abs(app.CompressedAudio));
                
                % Sauvegarder
                audiowrite(fullfile(path, file), normalized, app.SampleRate);
                
                uialert(app.UIFigure, sprintf('Audio compressé sauvegardé:\n%s', file), ...
                    'Succès', 'Icon', 'success');
                
            catch ME
                uialert(app.UIFigure, sprintf('Erreur: %s', ME.message), 'Erreur', 'Icon', 'error');
            end
        end
    end

    methods (Access = private)
        function createComponents(app)
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1200 800];
            app.UIFigure.Name = 'Codage Audio';
            app.UIFigure.Color = [0.95 0.95 0.97];
            app.UIFigure.Scrollable = 'on';

            app.MainPanel = uipanel(app.UIFigure);
            app.MainPanel.BackgroundColor = [1 1 1];
            app.MainPanel.Position = [20 20 1160 850];

            % Titre
            app.TitleLabel = uilabel(app.MainPanel);
            app.TitleLabel.FontSize = 24;
            app.TitleLabel.FontWeight = 'bold';
            app.TitleLabel.FontColor = [0.15 0.25 0.45];
            app.TitleLabel.HorizontalAlignment = 'center';
            app.TitleLabel.Position = [100 800 960 40];
            app.TitleLabel.Text = '🎵 CODAGE ET COMPRESSION AUDIO';

            % Boutons
            app.LoadButton = uibutton(app.MainPanel, 'push');
            app.LoadButton.ButtonPushedFcn = createCallbackFcn(app, @LoadButtonPushed, true);
            app.LoadButton.BackgroundColor = [0.39 0.59 0.39];
            app.LoadButton.FontSize = 13;
            app.LoadButton.FontWeight = 'bold';
            app.LoadButton.FontColor = [1 1 1];
            app.LoadButton.Position = [30 750 140 35];
            app.LoadButton.Text = '📂 CHARGER';

            app.PlayButton = uibutton(app.MainPanel, 'push');
            app.PlayButton.ButtonPushedFcn = createCallbackFcn(app, @PlayButtonPushed, true);
            app.PlayButton.BackgroundColor = [0.3 0.5 0.8];
            app.PlayButton.FontSize = 13;
            app.PlayButton.FontWeight = 'bold';
            app.PlayButton.FontColor = [1 1 1];
            app.PlayButton.Position = [180 750 160 35];
            app.PlayButton.Text = '▶ JOUER ORIGINAL';

            app.ProcessButton = uibutton(app.MainPanel, 'push');
            app.ProcessButton.ButtonPushedFcn = createCallbackFcn(app, @ProcessButtonPushed, true);
            app.ProcessButton.BackgroundColor = [0.27 0.51 0.71];
            app.ProcessButton.FontSize = 13;
            app.ProcessButton.FontWeight = 'bold';
            app.ProcessButton.FontColor = [1 1 1];
            app.ProcessButton.Position = [520 750 140 35];
            app.ProcessButton.Text = '⚙ TRAITER';

            app.PlayCompressedButton = uibutton(app.MainPanel, 'push');
            app.PlayCompressedButton.ButtonPushedFcn = createCallbackFcn(app, @PlayCompressedButtonPushed, true);
            app.PlayCompressedButton.BackgroundColor = [0.8 0.3 0.3];
            app.PlayCompressedButton.FontSize = 13;
            app.PlayCompressedButton.FontWeight = 'bold';
            app.PlayCompressedButton.FontColor = [1 1 1];
            app.PlayCompressedButton.Position = [670 750 180 35];
            app.PlayCompressedButton.Text = '▶ JOUER COMPRESSÉ';

            app.SaveButton = uibutton(app.MainPanel, 'push');
            app.SaveButton.ButtonPushedFcn = createCallbackFcn(app, @SaveButtonPushed, true);
            app.SaveButton.BackgroundColor = [0.5 0.6 0.3];
            app.SaveButton.FontSize = 13;
            app.SaveButton.FontWeight = 'bold';
            app.SaveButton.FontColor = [1 1 1];
            app.SaveButton.Position = [990 750 140 35];
            app.SaveButton.Text = '💾 SAUVEGARDER';

            % Axes pour signal original
            app.OriginalAxes = uiaxes(app.MainPanel);
            app.OriginalAxes.Position = [30 570 550 160];
            title(app.OriginalAxes, 'Signal Audio Original', 'FontSize', 12);
            xlabel(app.OriginalAxes, 'Temps (s)');
            ylabel(app.OriginalAxes, 'Amplitude');

            % Axes pour signal compressé
            app.CompressedAxes = uiaxes(app.MainPanel);
            app.CompressedAxes.Position = [600 570 550 160];
            title(app.CompressedAxes, 'Signal Audio Compressé', 'FontSize', 12);
            xlabel(app.CompressedAxes, 'Temps (s)');
            ylabel(app.CompressedAxes, 'Amplitude');

            % Zone de résultats
            app.ResultsArea = uitextarea(app.MainPanel);
            app.ResultsArea.Position = [30 330 550 220];
            app.ResultsArea.FontSize = 11;
            app.ResultsArea.Editable = 'off';
            app.ResultsArea.FontName = 'Consolas';

            % Zone données codées
            app.EncodedArea = uitextarea(app.MainPanel);
            app.EncodedArea.Position = [600 330 550 220];
            app.EncodedArea.FontSize = 9;
            app.EncodedArea.Editable = 'off';
            app.EncodedArea.FontName = 'Consolas';

            % Meilleur algo
            app.BestAlgoLabel = uilabel(app.MainPanel);
            app.BestAlgoLabel.FontSize = 16;
            app.BestAlgoLabel.FontWeight = 'bold';
            app.BestAlgoLabel.HorizontalAlignment = 'center';
            app.BestAlgoLabel.Position = [30 270 1100 40];
            app.BestAlgoLabel.Text = '';

            app.UIFigure.Visible = 'on';
        end
    end

    methods (Access = public)
        function app = AudioCodingInterface
            createComponents(app)
            registerApp(app, app.UIFigure)
            runStartupFcn(app, @startupFcn)
            if nargout == 0
                clear app
            end
        end

        function delete(app)
            if ~isempty(app.AudioPlayer) && isvalid(app.AudioPlayer)
                stop(app.AudioPlayer);
            end
            if ~isempty(app.CompressedPlayer) && isvalid(app.CompressedPlayer)
                stop(app.CompressedPlayer);
            end
            delete(app.UIFigure)
        end
    end
end

function truncated = truncateText(text, maxLength)
    if length(text) > maxLength
        truncated = [text(1:maxLength) '... (tronqué)'];
    else
        truncated = text;
    end
end