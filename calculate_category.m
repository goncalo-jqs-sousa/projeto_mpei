function category = calculate_category(hist_categories,hist_n_samples)

    hist_categories = cell2mat(hist_categories)
    cat_counter = zeros(4,1)'; % [1 10 17 23]
    unknown_cat = 0;
    for h = 1:hist_n_samples
        if hist_categories(h) == 1
            cat_counter(1) = cat_counter(1)+1;
        elseif (hist_categories(h) == 10)
            cat_counter(2) = cat_counter(2)+1;
        elseif (hist_categories(h) == 17)
            cat_counter(3) = cat_counter(3)+1;
        elseif (hist_categories(h) == 23)
            cat_counter(4) = cat_counter(4)+1;
        else
            unknown_cat = unknown_cat+1;
        end
    end
    most_viewed_category = max(cat_counter);
    cat_index = find(cat_counter == most_viewed_category);
    category = cat_index(1);
end