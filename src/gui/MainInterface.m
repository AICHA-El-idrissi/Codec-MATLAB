classdef MainInterface < matlab.apps.AppBase

    properties (Access = public)
        UIFigure matlab.ui.Figure
        MainPanel matlab.ui.container.Panel
        TitleLabel matlab.ui.control.Label
        QuestionLabel matlab.ui.control.Label
        TextButton matlab.ui.control.Button
        ImageButton matlab.ui.control.Button
        AudioButton matlab.ui.control.Button
        FooterLabel matlab.ui.control.Label
        LogoLabel matlab.ui.control.Label
        
        % Panneaux de confirmation
        TextConfirmPanel matlab.ui.container.Panel
        TextConfirmLabel matlab.ui.control.Label
        TextYesButton matlab.ui.control.Button
        TextNoButton matlab.ui.control.Button
        
        ImageConfirmPanel matlab.ui.container.Panel
        ImageConfirmLabel matlab.ui.control.Label
        ImageYesButton matlab.ui.control.Button
        ImageNoButton matlab.ui.control.Button
        
        AudioConfirmPanel matlab.ui.container.Panel
        AudioConfirmLabel matlab.ui.control.Label
        AudioYesButton matlab.ui.control.Button
        AudioNoButton matlab.ui.control.Button
    end

    methods (Access = private)
        function startupFcn(app)
            app.UIFigure.Position = [100 100 700 550];
            movegui(app.UIFigure, 'center');
        end

        function TextButtonPushed(app, ~)
            % Masquer le panneau principal et afficher la confirmation texte
            app.MainPanel.Visible = 'off';
            app.TextConfirmPanel.Visible = 'on';
        end

        function ImageButtonPushed(app, ~)
            % Masquer le panneau principal et afficher la confirmation image
            app.MainPanel.Visible = 'off';
            app.ImageConfirmPanel.Visible = 'on';
        end
        
        function AudioButtonPushed(app, ~)
            % Masquer le panneau principal et afficher la confirmation audio
            app.MainPanel.Visible = 'off';
            app.AudioConfirmPanel.Visible = 'on';
        end
        
        % Callbacks pour les confirmations TEXTE
        function TextYesButtonPushed(app, ~)
            try
                TextCodingInterface;
                app.TextConfirmPanel.Visible = 'off';
                app.MainPanel.Visible = 'on';
                uialert(app.UIFigure, 'Interface de codage de texte ouverte.', 'Information', 'Icon', 'info');
            catch ME
                app.TextConfirmPanel.Visible = 'off';
                app.MainPanel.Visible = 'on';
                uialert(app.UIFigure, sprintf('Erreur: %s', ME.message), 'Erreur', 'Icon', 'error');
            end
        end
        
        function TextNoButtonPushed(app, ~)
            % Retourner au panneau principal sans rien faire
            app.TextConfirmPanel.Visible = 'off';
            app.MainPanel.Visible = 'on';
        end
        
        % Callbacks pour les confirmations IMAGE
        function ImageYesButtonPushed(app, ~)
            try
                ImageCodingInterface;
                app.ImageConfirmPanel.Visible = 'off';
                app.MainPanel.Visible = 'on';
                uialert(app.UIFigure, 'Interface de codage d''image ouverte.', 'Information', 'Icon', 'info');
            catch ME
                app.ImageConfirmPanel.Visible = 'off';
                app.MainPanel.Visible = 'on';
                uialert(app.UIFigure, sprintf('Erreur: %s', ME.message), 'Erreur', 'Icon', 'error');
            end
        end
        
        function ImageNoButtonPushed(app, ~)
            app.ImageConfirmPanel.Visible = 'off';
            app.MainPanel.Visible = 'on';
        end
        
        % Callbacks pour les confirmations AUDIO
        function AudioYesButtonPushed(app, ~)
            try
                AudioCodingInterface;
                app.AudioConfirmPanel.Visible = 'off';
                app.MainPanel.Visible = 'on';
                uialert(app.UIFigure, 'Interface de codage audio ouverte.', 'Information', 'Icon', 'info');
            catch ME
                app.AudioConfirmPanel.Visible = 'off';
                app.MainPanel.Visible = 'on';
                uialert(app.UIFigure, sprintf('Erreur: %s', ME.message), 'Erreur', 'Icon', 'error');
            end
        end
        
        function AudioNoButtonPushed(app, ~)
            app.AudioConfirmPanel.Visible = 'off';
            app.MainPanel.Visible = 'on';
        end
    end

    methods (Access = private)
        function createComponents(app)
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 700 550];
            app.UIFigure.Name = 'Système de Compression et Codage';
            app.UIFigure.Color = [0.95 0.95 0.97];

            % ========== PANNEAU PRINCIPAL ==========
            app.MainPanel = uipanel(app.UIFigure);
            app.MainPanel.BackgroundColor = [1 1 1];
            app.MainPanel.Position = [50 50 600 450];
            app.MainPanel.BorderType = 'none';

            app.TitleLabel = uilabel(app.MainPanel);
            app.TitleLabel.FontSize = 24;
            app.TitleLabel.FontWeight = 'bold';
            app.TitleLabel.FontColor = [0.15 0.25 0.45];
            app.TitleLabel.HorizontalAlignment = 'center';
            app.TitleLabel.Position = [50 370 500 40];
            app.TitleLabel.Text = 'Système de Compression et Codage';

            app.QuestionLabel = uilabel(app.MainPanel);
            app.QuestionLabel.FontSize = 16;
            app.QuestionLabel.FontWeight = 'bold';
            app.QuestionLabel.HorizontalAlignment = 'center';
            app.QuestionLabel.Position = [100 310 400 30];
            app.QuestionLabel.Text = 'Que voulez-vous coder ?';

            % Bouton TEXTE
            app.TextButton = uibutton(app.MainPanel, 'push');
            app.TextButton.ButtonPushedFcn = createCallbackFcn(app, @TextButtonPushed, true);
            app.TextButton.BackgroundColor = [0.27 0.51 0.71];
            app.TextButton.FontSize = 16;
            app.TextButton.FontWeight = 'bold';
            app.TextButton.FontColor = [1 1 1];
            app.TextButton.Position = [80 210 170 60];
            app.TextButton.Text = 'TEXTE';

            % Bouton IMAGE
            app.ImageButton = uibutton(app.MainPanel, 'push');
            app.ImageButton.ButtonPushedFcn = createCallbackFcn(app, @ImageButtonPushed, true);
            app.ImageButton.BackgroundColor = [0.39 0.59 0.39];
            app.ImageButton.FontSize = 16;
            app.ImageButton.FontWeight = 'bold';
            app.ImageButton.FontColor = [1 1 1];
            app.ImageButton.Position = [270 210 170 60];
            app.ImageButton.Text = 'IMAGE';
            
            % Bouton AUDIO
            app.AudioButton = uibutton(app.MainPanel, 'push');
            app.AudioButton.ButtonPushedFcn = createCallbackFcn(app, @AudioButtonPushed, true);
            app.AudioButton.BackgroundColor = [0.8 0.4 0.5];
            app.AudioButton.FontSize = 16;
            app.AudioButton.FontWeight = 'bold';
            app.AudioButton.FontColor = [1 1 1];
            app.AudioButton.Position = [175 130 170 60];
            app.AudioButton.Text = 'AUDIO';

            app.FooterLabel = uilabel(app.MainPanel);
            app.FooterLabel.FontSize = 11;
            app.FooterLabel.FontColor = [0.5 0.5 0.5];
            app.FooterLabel.HorizontalAlignment = 'center';
            app.FooterLabel.Position = [100 60 400 20];
            app.FooterLabel.Text = 'CodecPro - Plateforme  de Compression et codage';

            app.LogoLabel = uilabel(app.MainPanel);
            app.LogoLabel.FontSize = 13;
            app.LogoLabel.FontWeight = 'bold';
            app.LogoLabel.FontColor = [0.2 0.3 0.5];
            app.LogoLabel.HorizontalAlignment = 'center';
            app.LogoLabel.Position = [100 30 400 20];
            app.LogoLabel.Text = 'ENSA-Fès | Aicha El idrissi | version1.0 | 2026';

            % ========== PANNEAU DE CONFIRMATION TEXTE ==========
            app.TextConfirmPanel = uipanel(app.UIFigure);
            app.TextConfirmPanel.BackgroundColor = [1 1 1];
            app.TextConfirmPanel.Position = [50 50 600 450];
            app.TextConfirmPanel.BorderType = 'none';
            app.TextConfirmPanel.Visible = 'off';
            
            app.TextConfirmLabel = uilabel(app.TextConfirmPanel);
            app.TextConfirmLabel.FontSize = 18;
            app.TextConfirmLabel.FontWeight = 'bold';
            app.TextConfirmLabel.FontColor = [0.15 0.25 0.45];
            app.TextConfirmLabel.HorizontalAlignment = 'center';
            app.TextConfirmLabel.Position = [100 280 400 40];
            app.TextConfirmLabel.Text = 'Voulez-vous coder un TEXTE ?';
            
            app.TextYesButton = uibutton(app.TextConfirmPanel, 'push');
            app.TextYesButton.ButtonPushedFcn = createCallbackFcn(app, @TextYesButtonPushed, true);
            app.TextYesButton.BackgroundColor = [0.2 0.7 0.3];
            app.TextYesButton.FontSize = 16;
            app.TextYesButton.FontWeight = 'bold';
            app.TextYesButton.FontColor = [1 1 1];
            app.TextYesButton.Position = [150 180 140 50];
            app.TextYesButton.Text = 'OUI';
            
            app.TextNoButton = uibutton(app.TextConfirmPanel, 'push');
            app.TextNoButton.ButtonPushedFcn = createCallbackFcn(app, @TextNoButtonPushed, true);
            app.TextNoButton.BackgroundColor = [0.8 0.2 0.2];
            app.TextNoButton.FontSize = 16;
            app.TextNoButton.FontWeight = 'bold';
            app.TextNoButton.FontColor = [1 1 1];
            app.TextNoButton.Position = [310 180 140 50];
            app.TextNoButton.Text = 'NON';

            % ========== PANNEAU DE CONFIRMATION IMAGE ==========
            app.ImageConfirmPanel = uipanel(app.UIFigure);
            app.ImageConfirmPanel.BackgroundColor = [1 1 1];
            app.ImageConfirmPanel.Position = [50 50 600 450];
            app.ImageConfirmPanel.BorderType = 'none';
            app.ImageConfirmPanel.Visible = 'off';
            
            app.ImageConfirmLabel = uilabel(app.ImageConfirmPanel);
            app.ImageConfirmLabel.FontSize = 18;
            app.ImageConfirmLabel.FontWeight = 'bold';
            app.ImageConfirmLabel.FontColor = [0.15 0.25 0.45];
            app.ImageConfirmLabel.HorizontalAlignment = 'center';
            app.ImageConfirmLabel.Position = [100 280 400 40];
            app.ImageConfirmLabel.Text = 'Voulez-vous coder une IMAGE ?';
            
            app.ImageYesButton = uibutton(app.ImageConfirmPanel, 'push');
            app.ImageYesButton.ButtonPushedFcn = createCallbackFcn(app, @ImageYesButtonPushed, true);
            app.ImageYesButton.BackgroundColor = [0.2 0.7 0.3];
            app.ImageYesButton.FontSize = 16;
            app.ImageYesButton.FontWeight = 'bold';
            app.ImageYesButton.FontColor = [1 1 1];
            app.ImageYesButton.Position = [150 180 140 50];
            app.ImageYesButton.Text = 'OUI';
            
            app.ImageNoButton = uibutton(app.ImageConfirmPanel, 'push');
            app.ImageNoButton.ButtonPushedFcn = createCallbackFcn(app, @ImageNoButtonPushed, true);
            app.ImageNoButton.BackgroundColor = [0.8 0.2 0.2];
            app.ImageNoButton.FontSize = 16;
            app.ImageNoButton.FontWeight = 'bold';
            app.ImageNoButton.FontColor = [1 1 1];
            app.ImageNoButton.Position = [310 180 140 50];
            app.ImageNoButton.Text = 'NON';

            % ========== PANNEAU DE CONFIRMATION AUDIO ==========
            app.AudioConfirmPanel = uipanel(app.UIFigure);
            app.AudioConfirmPanel.BackgroundColor = [1 1 1];
            app.AudioConfirmPanel.Position = [50 50 600 450];
            app.AudioConfirmPanel.BorderType = 'none';
            app.AudioConfirmPanel.Visible = 'off';
            
            app.AudioConfirmLabel = uilabel(app.AudioConfirmPanel);
            app.AudioConfirmLabel.FontSize = 18;
            app.AudioConfirmLabel.FontWeight = 'bold';
            app.AudioConfirmLabel.FontColor = [0.15 0.25 0.45];
            app.AudioConfirmLabel.HorizontalAlignment = 'center';
            app.AudioConfirmLabel.Position = [100 280 400 40];
            app.AudioConfirmLabel.Text = 'Voulez-vous coder un AUDIO ?';
            
            app.AudioYesButton = uibutton(app.AudioConfirmPanel, 'push');
            app.AudioYesButton.ButtonPushedFcn = createCallbackFcn(app, @AudioYesButtonPushed, true);
            app.AudioYesButton.BackgroundColor = [0.2 0.7 0.3];
            app.AudioYesButton.FontSize = 16;
            app.AudioYesButton.FontWeight = 'bold';
            app.AudioYesButton.FontColor = [1 1 1];
            app.AudioYesButton.Position = [150 180 140 50];
            app.AudioYesButton.Text = 'OUI';
            
            app.AudioNoButton = uibutton(app.AudioConfirmPanel, 'push');
            app.AudioNoButton.ButtonPushedFcn = createCallbackFcn(app, @AudioNoButtonPushed, true);
            app.AudioNoButton.BackgroundColor = [0.8 0.2 0.2];
            app.AudioNoButton.FontSize = 16;
            app.AudioNoButton.FontWeight = 'bold';
            app.AudioNoButton.FontColor = [1 1 1];
            app.AudioNoButton.Position = [310 180 140 50];
            app.AudioNoButton.Text = 'NON';

            app.UIFigure.Visible = 'on';
        end
    end

    methods (Access = public)
        function app = MainInterface
            createComponents(app)
            registerApp(app, app.UIFigure)
            runStartupFcn(app, @startupFcn)
            if nargout == 0
                clear app
            end
        end

        function delete(app)
            delete(app.UIFigure)
        end
    end
end
