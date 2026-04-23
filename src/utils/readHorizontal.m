function vec = readHorizontal(img)
    % Lecture horizontale d'une image
    % Entrée: matrice image
    % Sortie: vecteur 1D (lecture ligne par ligne)
    
    [rows, cols] = size(img);
    vec = zeros(1, rows * cols);
    
    idx = 1;
    for i = 1:rows
        for j = 1:cols
            vec(idx) = img(i, j);
            idx = idx + 1;
        end
    end
end