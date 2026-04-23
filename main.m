% ========================================
% PROJET CODAGE - ENSA FES
% Aicha EL IDRISSI - 2ème Année ISEIA
% ========================================

clear; clc; close all;

% Ajouter les chemins nécessaires
addpath(fullfile(pwd, 'src', 'gui'));
addpath(fullfile(pwd, 'src', 'utils'));

% Lancer le Splash Screen
fprintf('========================================\n');
fprintf('  DÉMARRAGE DE CODECPRO\n');
fprintf('  Système de Compression et Codage\n');
fprintf('========================================\n\n');

try
    % Changer vers le dossier GUI
    cd(fullfile(pwd, 'src', 'gui'));
    
    % Lancer l'application
    SplashScreen;
    
    fprintf('✓ Application lancée avec succès!\n\n');
    
catch ME
    fprintf('✗ Erreur lors du lancement:\n');
    fprintf('  %s\n\n', ME.message);
    
    % Revenir au dossier racine en cas d'erreur
    cd(fullfile(pwd, '..', '..'));
end