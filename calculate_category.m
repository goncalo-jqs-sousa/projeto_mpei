function [category,n_cat,most_views] = calculate_category(hist_categories,hist_n_samples,cat_list)

    hist_categories = cell2mat(hist_categories);
    cat_counter = zeros(5,1)'; % [1 10 17 25 0]
    cat_list = [1 10 17 25 0];

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
            %categoria desconhecida
            cat_counter(5) = cat_counter(5)+1;
        end
    end

    most_views = max(cat_counter);
    index_of_most_views = find(cat_counter == most_views);
    category_number = index_of_most_views(1);

    if category_number == cat_list(1)
        category = "Film & Animation";
         n_cat = cat_list(1);
    elseif category_number == cat_list(2)
        category = "Music";
         n_cat = cat_list(2);
    elseif category_number == cat_list(3)
        category = "Sports";
         n_cat = cat_list(3);
    elseif category_number == cat_list(4)
        category = "News & Politics";
         n_cat = cat_list(4);
    else
        category = "undefined";
         n_cat = cat_list(5);
    end
end