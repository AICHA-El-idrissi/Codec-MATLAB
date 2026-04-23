function vec = readZigzag(img)
    % Lecture en zigzag d'une image
    % Entrée: matrice image carrée
    % Sortie: vecteur 1D (lecture en zigzag)
    
    [rows, cols] = size(img);
    vec = zeros(1, rows * cols);
    
    idx = 1;
    row = 1;
    col = 1;
    
    % Direction: 1 = montée, -1 = descente
    direction = 1;
    
    while idx <= rows * cols
        vec(idx) = img(row, col);
        idx = idx + 1;
        
        if direction == 1
            % Montée vers le haut-droite
            if row == 1 && col < cols
                col = col + 1;
                direction = -1;
            elseif col == cols
                row = row + 1;
                direction = -1;
            else
                row = row - 1;
                col = col + 1;
            end
        else
            % Descente vers le bas-gauche
            if col == 1 && row < rows
                row = row + 1;
                direction = 1;
            elseif row == rows
                col = col + 1;
                direction = 1;
            else
                row = row + 1;
                col = col - 1;
            end
        end
    end
end