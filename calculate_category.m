function [category,most_views] = calculate_category(hist_categories,hist_n_samples)

    hist_categories = cell2mat(hist_categories);
    cat_counter = zeros(4,1)'; % [1 10 17 25]
    cat_list = [1 10 17 25];
    unknown_cat = 0;
    for h = 1:hist_n_samples
        if hist_categories(h) == cat_list(1)
            cat_counter(1) = cat_counter(1)+1;
        elseif (hist_categories(h) == cat_list(2))
            cat_counter(2) = cat_counter(2)+1;
        elseif (hist_categories(h) == cat_list(3))
            cat_counter(3) = cat_counter(3)+1;
        elseif (hist_categories(h) == cat_list(4))
            cat_counter(4) = cat_counter(4)+1;
        else
            unknown_cat = unknown_cat+1;
        end
    end
    most_views = max(cat_counter);
    cat_index = find(cat_counter == most_views);
    category_number = cat_index(1);
    if category_number == cat_list(1)
        category = "Film & Animation";
    elseif category_number == cat_list(2)
        category = "Music";
    elseif category_number == cat_list(3)
        category = "Sports";
    elseif category_number == cat_list(4)
        category = "News & Politics";
    else
        category = "undefined";
        return
    end
end