function [category,n_cat,most_views] = calculate_category(hist_categories,hist_n_samples)

    hist_categories = cell2mat(hist_categories);
    cat_counter = zeros(4,1)'; % [1 10 17 25]
    cat_list = [1 10 17 25];

    for h = 1:hist_n_samples
        if hist_categories(h) == cat_list(1)
            cat_counter(1) = cat_counter(1)+1;
        elseif (hist_categories(h) == cat_list(2))
            cat_counter(2) = cat_counter(2)+1;
        elseif (hist_categories(h) == cat_list(3))
            cat_counter(3) = cat_counter(3)+1;
        elseif (hist_categories(h) == cat_list(4))
            cat_counter(4) = cat_counter(4)+1;
        end
    end

    most_views = max(cat_counter);
    index_of_most_views = find(cat_counter == most_views);

    category_number_index = index_of_most_views(1);

    if category_number_index == 1
        category = "Film & Animation";
         n_cat = 1;
    elseif category_number_index == 2
        category = "Music";
         n_cat = 10;
    elseif category_number_index == 3
        category = "Sports";
         n_cat = 17;
    elseif category_number_index == 4
        category = "News & Politics";
         n_cat = 25;
    else
        category = "undefined";
         n_cat = 0;
    end
end