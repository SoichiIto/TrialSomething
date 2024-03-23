function actx_excel2                                             
    %https://jp.mathworks.com/help/matlab/matlab_external/example-reading-excel-spreadsheet-data_ja_JP.html
    % Copyright 2013 The MathWorks, Inc.
    % Use Excel as a data server for MATLAB

    % Start data server
    [exl,  exlWkbk ,exlData] = startServ1();
    % Scope variables from startServ1 to main function
    %exl; exlWkbk; exlData;
    % Start graph server
    %startServ2
    % Scope variables from startServ2 to main function
   % exl2; exlWkbk2; wb; Shapes;
    
   %% Extract column data
    % Time:1, inptAil:2, inptEle:3, inptRud:4, respAil:5, respEle:6, respRud:7
    for ii = 1:size(exlData,2)
       matData(:,ii) = reshape([exlData{2:end,ii}],size(exlData(2:end,ii)));
       lBoxList{ii} = [exlData{1,ii}];
    end
    
    lbs = '';
    tme = matData(:,1); % Time data

   if exist('exl','var')
      exl.unregisterevent({'WorkbookBeforeClose',@close_event1});
      exlWkbk.Close
      exl.Quit
   end

    %% Start data server
    function [exl ,exlWkbk ,exlData]  = startServ1()
       exl = actxserver('excel.application');
       % Load data from an excel file
       % Get Workbook interface and open file
       exlWkbk = exl.Workbooks; 
       exlFile = exlWkbk.Open([docroot '/techdoc/matlab_external/examples/input_resp_data.xls']);
       % Get interface for Sheet1 and read data into range object
       exlSheet1 = exlFile.Sheets.Item('Sheet1');
       robj = exlSheet1.Columns.End(4);
       numrows = robj.row;
       dat_range = ['A1:G' num2str(numrows)]; 
       rngObj = exlSheet1.Range(dat_range);
       % Read data from excel range object into MATLAB cell array
       exlData = rngObj.Value; 
       exl.registerevent({'WorkbookBeforeClose',@close_event1});
    end % startServ1

%     % Handle situation where user closes Excel graph file
%     function close_event2(varargin)
%     % MATLAB does not currently support 
%     % pass by reference arguments for events
%     % so you cannot set Cancel argument to True
%     % Instead, just quit server and restart
%        if exist('exl2','var')
%           wb.Saved = true;
%           exlWkbk2.Close
%           exl2.Quit;
%        end
% %    startServ2
%     end % close_event2

    %% Terminate Excel process
%     function deleteFig(src,evt)
%        if exist('exl','var')
%           exl.unregisterevent({'WorkbookBeforeClose',@close_event1});
%           exlWkbk.Close
%           exl.Quit
%        end
%        if exist('exl2','var')
%           wb.Saved = true;
%           exl2.unregisterevent({'WorkbookBeforeClose',@close_event2});
%           exlWkbk2.Close
%           exl2.Quit
%        end
%     end % deleteFig   
end