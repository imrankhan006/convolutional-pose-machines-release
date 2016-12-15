function scores = applyDNN(images, net, nstage)
    input_data = {single(images)};
    % do forward pass to get scores
    % scores are now Width x Height x Channels x Num
    net.forward(input_data);
    scores = cell(1, nstage);
    for s = 1:nstage
        string_to_search = sprintf('stage%d', s);
        blob_id_C = strfind(net.blob_names, string_to_search);
        blob_id = find(not(cellfun('isempty', blob_id_C)));
        blob_id = blob_id(end);
        scores{s} = net.blob_vec(blob_id).get_data();
    end
