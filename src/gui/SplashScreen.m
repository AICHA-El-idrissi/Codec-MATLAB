classdef SplashScreen < matlab.apps.AppBase

    properties (Access = public)
        UIFigure matlab.ui.Figure
        MainPanel matlab.ui.container.Panel
        ENSALogo matlab.ui.control.Image
        CenterLogo matlab.ui.control.Image
        TitleLabel matlab.ui.control.Label
        SubtitleLabel matlab.ui.control.Label
        ProgressBg matlab.ui.container.Panel
        ProgressFill matlab.ui.container.Panel
        ProgressText matlab.ui.control.Label
        StatusLabel matlab.ui.control.Label
        InfoLabel matlab.ui.control.Label
        VersionLabel matlab.ui.control.Label
        CopyrightLabel matlab.ui.control.Label
        ThemeButton matlab.ui.control.Button
    end

    properties (Access = private)
        Timer timer
        AnimTimer timer
        Progress double = 0
        IsDark logical = false
        Pulse double = 0
    end

    methods (Access = private)
        %% ================= STARTUP =================%
        function startupFcn(app)
            movegui(app.UIFigure,'center');
            loadLogos(app);
            applyTheme(app);

            app.Timer = timer('ExecutionMode','fixedRate','Period',0.05,...
                'TimerFcn',@(src,evt)safeUpdateProgress(app));

            app.AnimTimer = timer('ExecutionMode','fixedRate','Period',0.05,...
                'TimerFcn',@(src,evt)safeAnimateLogo(app));

            start(app.Timer);
            start(app.AnimTimer);

            app.UIFigure.CloseRequestFcn = @(src,evt)closeApp(app);
        end

        %% ================= LOGOS =================%
        function loadLogos(app)
            topLogo = fullfile(pwd, '..', '..', 'assets', 'images', 'ENSAFES_logo.png');
            centerLogo = fullfile(pwd, '..', '..','assets','images','logo_app.png');

            if exist(topLogo,'file')
                app.ENSALogo.ImageSource = topLogo;
            end
            if exist(centerLogo,'file')
                app.CenterLogo.ImageSource = centerLogo;
            end
        end

        %% ================= THEME =================%
        function toggleTheme(app,~)
            app.IsDark = ~app.IsDark;
            applyTheme(app);
        end

        function applyTheme(app)
            if app.IsDark
                bg = [0.06 0.08 0.13];
                panel = [0.1 0.13 0.2];
                title = [0.92 0.95 1];
                sub = [0.65 0.75 0.9];
                bar = [0.2 0.6 1];
                app.ThemeButton.Text = '☀';
            else
                bg = [0.96 0.97 1];
                panel = [1 1 1];
                title = [0.15 0.2 0.3];
                sub = [0.45 0.5 0.6];
                bar = [0.15 0.45 0.85];
                app.ThemeButton.Text = '🌙';
            end

            app.UIFigure.Color = bg;
            app.MainPanel.BackgroundColor = panel;
            app.TitleLabel.FontColor = title;
            app.SubtitleLabel.FontColor = sub;
            app.StatusLabel.FontColor = sub;
            app.ProgressFill.BackgroundColor = bar;
            app.ProgressBg.BackgroundColor = sub * 0.7;

            if ~isempty(app.InfoLabel) && isvalid(app.InfoLabel)
                app.InfoLabel.FontColor = sub;
            end
            if ~isempty(app.VersionLabel) && isvalid(app.VersionLabel)
                app.VersionLabel.FontColor = sub;
            end
            if ~isempty(app.CopyrightLabel) && isvalid(app.CopyrightLabel)
                app.CopyrightLabel.FontColor = sub;
            end
        end

        %% ================= PROGRESS =================%
        function safeUpdateProgress(app)
            if isvalid(app.UIFigure)
                updateProgress(app)
            end
        end

        function updateProgress(app)
            step = 0.8 + 0.5*rand();
            app.Progress = min(app.Progress + step, 100);
            app.ProgressFill.Position(3) = app.ProgressBg.Position(3) * app.Progress / 100;
            app.ProgressText.Text = sprintf('%d %%', round(app.Progress));

            if app.Progress < 30
                app.StatusLabel.Text = 'Initialisation du système...';
            elseif app.Progress < 60
                app.StatusLabel.Text = 'Chargement des composants...';
            elseif app.Progress < 90
                app.StatusLabel.Text = 'Optimisation graphique...';
            else
                app.StatusLabel.Text = 'Démarrage...';
            end

            if app.Progress >= 100
                closeApp(app);
            end
        end

        %% ================= ANIMATION =================%
        function safeAnimateLogo(app)
            if isvalid(app.CenterLogo)
                animateLogo(app)
            end
        end

        function animateLogo(app)
            app.Pulse = app.Pulse + 0.08;
            scale = 1 + 0.05 * sin(app.Pulse);

            w = 220 * scale;
            h = 220 * scale;
            app.CenterLogo.Position = [450 - w/2, 300 - h/2, w, h];
        end

        %% ================= FERMETURE =================%
        function closeApp(app)
            if ~isempty(app.Timer) && isvalid(app.Timer)
                stop(app.Timer); delete(app.Timer);
            end
            if ~isempty(app.AnimTimer) && isvalid(app.AnimTimer)
                stop(app.AnimTimer); delete(app.AnimTimer);
            end
            
            % 🔥 AJOUT: Lancer MainInterface avant de fermer
            try
                MainInterface;
            catch ME
                warning('Erreur lors du lancement de MainInterface: %s', ME.message);
            end
            
            delete(app.UIFigure);
        end
    end

    %% ================= UI =================%
    methods (Access = private)
        function createComponents(app)
            app.UIFigure = uifigure('Visible','off','Resize','off');
            app.UIFigure.Position = [100 100 900 600];
            app.UIFigure.Name = 'CodecPro – Splash';

            app.MainPanel = uipanel(app.UIFigure,'BorderType','none');
            app.MainPanel.Position = [30 30 840 540];

            app.ENSALogo = uiimage(app.MainPanel);
            app.ENSALogo.Position = [20 460 140 90];
            app.ENSALogo.ScaleMethod = 'fit';

            app.ThemeButton = uibutton(app.MainPanel,'push');
            app.ThemeButton.Position = [780 480 40 40];
            app.ThemeButton.ButtonPushedFcn = @(~,~)toggleTheme(app);

            app.CenterLogo = uiimage(app.MainPanel);
            app.CenterLogo.Position = [340 270 220 220]; 
            app.CenterLogo.ScaleMethod = 'fit';

            app.TitleLabel = uilabel(app.MainPanel,...
                'Text','BIENVENUE',...
                'FontSize',38,...
                'FontWeight','bold',...
                'FontName','Segoe UI Semibold',...
                'HorizontalAlignment','center');
            app.TitleLabel.Position = [100 210 640 60];

            app.SubtitleLabel = uilabel(app.MainPanel,...
                'Text','Plateforme CodecPro – Compression & Codage',...
                'FontSize',22,...
                'FontName','Segoe UI',...
                'HorizontalAlignment','center');
            app.SubtitleLabel.Position = [100 170 640 35];

            app.InfoLabel = uilabel(app.MainPanel,...
                'Text','© 2026 Aicha EL IDRISSI',...
                'FontSize',14,...
                'FontWeight','bold',...
                'FontName','Segoe UI',...
                'HorizontalAlignment','center');
            app.InfoLabel.Position = [170 140 500 25];

            app.ProgressBg = uipanel(app.MainPanel,'BorderType','none');
            app.ProgressBg.Position = [170 110 500 18];
            app.ProgressFill = uipanel(app.ProgressBg,'BorderType','none');
            app.ProgressFill.Position = [0 0 0 18];

            app.ProgressText = uilabel(app.MainPanel,...
                'Text','0 %',...
                'FontSize',16,...
                'FontWeight','bold',...
                'FontName','Segoe UI',...
                'HorizontalAlignment','center');
            app.ProgressText.Position = [170 80 500 25];

            app.StatusLabel = uilabel(app.MainPanel,...
                'Text','Initialisation...',...
                'FontSize',15,...
                'FontName','Segoe UI',...
                'HorizontalAlignment','center');
            app.StatusLabel.Position = [100 50 640 25];

            app.VersionLabel = uilabel(app.MainPanel,...
                'Text','Version 1.0.0',...
                'FontSize',13,...
                'HorizontalAlignment','center');
            app.VersionLabel.Position = [100 25 640 20];

            app.CopyrightLabel = uilabel(app.MainPanel,...
                'Text','© 2026 CodecPro – Tous droits réservés',...
                'FontSize',12,...
                'HorizontalAlignment','center');
            app.CopyrightLabel.Position = [100 5 640 18];

            app.UIFigure.Visible = 'on';
        end
    end

    %% ================= CONSTRUCTOR =================%
    methods (Access = public)
        function app = SplashScreen
            createComponents(app)
            registerApp(app, app.UIFigure)
            runStartupFcn(app, @startupFcn)
        end
    end
end