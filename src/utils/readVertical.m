function vec = readVertical(img)
    % Lecture verticale d'une image
    % Entrée: matrice image
    % Sortie: vecteur 1D (lecture colonne par colonne)
    
    [rows, cols] = size(img);
    vec = zeros(1, rows * cols);
    
    idx = 1;
    for j = 1:cols
        for i = 1:rows
            vec(idx) = img(i, j);
            idx = idx + 1;
        end
    end
end