function method = ChooseEdgeCorrection()

    choice = questdlg('Do you wish to use edge correction?',...
        'Edge Correction',...
        'Yes','No','Cancel','Cancel');
    if (choice == "Yes")
        method = 1;
    elseif (choice == "No")
        method = 0;
    else 
        method = -1;
    end
    
    return;

end