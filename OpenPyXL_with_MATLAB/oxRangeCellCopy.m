function oxRangeCellCopy(sheet,min_row,min_col,max_row,max_col,dest_row,dest_col)
    
    %コピー元の結合されたを取得する
    merged_cells = py.list(py.copy.copy(sheet.merged_cells));

    %コピー元の結合されたセルの結合を解除する
    for merged_cell = merged_cells
        if merged_cell{1}.min_row >= min_row && ...
           merged_cell{1}.min_col >= min_col && ...
           merged_cell{1}.max_row <= max_row && ...
           merged_cell{1}.max_col <= max_col

            % 結合セルを解除する
            sheet.unmerge_cells(merged_cell{1}.coord);

        end
    end
    
    % コピー先への相対移動量（シフト量）を求める
    shift_row = dest_row - min_row;
    shift_col = dest_col - min_col;
    
    % 全セルコピー    
    for col = py.range( int64(min_col),int64(max_col + 1))
        %セル幅をコピーする
        strSrcCell = py.openpyxl.utils.cell.get_column_letter(col{1});
        strDstCell = py.openpyxl.utils.cell.get_column_letter(col{1} + shift_col);
        col_dim = sheet.column_dimensions.get(strSrcCell);
        if ~isa(col_dim,'py.NoneType')
            sheet.column_dimensions{strDstCell}.auto_size       = sheet.column_dimensions{strSrcCell}.auto_size;
            sheet.column_dimensions{strDstCell}.bestFit         = sheet.column_dimensions{strSrcCell}.bestFit;
            sheet.column_dimensions{strDstCell}.collapsed       = sheet.column_dimensions{strSrcCell}.collapsed;
%            sheet.column_dimensions{strDstCell}.customWidth     =
%            sheet.column_dimensions{strSrcCell}.customWidth; % 読み取り専用
            sheet.column_dimensions{strDstCell}.hidden          = sheet.column_dimensions{strSrcCell}.hidden;
            sheet.column_dimensions{strDstCell}.index           = sheet.column_dimensions{strSrcCell}.index;
%             sheet.column_dimensions{strDstCell}.max             =
%             sheet.column_dimensions{strSrcCell}.max;    % 設定不可
%             sheet.column_dimensions{strDstCell}.min             =
%             sheet.column_dimensions{strSrcCell}.min;    % 設定不可
            sheet.column_dimensions{strDstCell}.outline_level   = sheet.column_dimensions{strSrcCell}.outline_level;
            sheet.column_dimensions{strDstCell}.outlineLevel    = sheet.column_dimensions{strSrcCell}.outlineLevel;
%             sheet.column_dimensions{strDstCell}.style           = sheet.column_dimensions{strSrcCell}.style;      % 設定不可
%             sheet.column_dimensions{strDstCell}.visible         = sheet.column_dimensions{strSrcCell}.visible;    % 設定不可
            sheet.column_dimensions{strDstCell}.width           = sheet.column_dimensions{strSrcCell}.width;
        end
        
        for row = py.range(int64(min_row),int64(max_row + 1) )
             % 最初の列の時セルの高さをコピー。
             if col{1} == min_col
                row_dim = sheet.row_dimensions.get(col{1});
                if ~isa(row_dim,'py.NoneType')
                    sheet.row_dimensions{row{1} + shift_row }.collapsed     = sheet.row_dimensions{row{1}}.collapsed;
                    sheet.row_dimensions{row{1} + shift_row }.customFormat  = sheet.row_dimensions{row{1}}.customFormat;
                    sheet.row_dimensions{row{1} + shift_row }.customHeight  = sheet.row_dimensions{row{1}}.customHeight;
                    sheet.row_dimensions{row{1} + shift_row }.height        = sheet.row_dimensions{row{1}}.height;
                    sheet.row_dimensions{row{1} + shift_row }.hidden        = sheet.row_dimensions{row{1}}.hidden;
                    sheet.row_dimensions{row{1} + shift_row }.ht            = sheet.row_dimensions{row{1}}.ht;
                    sheet.row_dimensions{row{1} + shift_row }.index         = sheet.row_dimensions{row{1}}.index;
                    sheet.row_dimensions{row{1} + shift_row }.outline_level = sheet.row_dimensions{row{1}}.outline_level;
                    sheet.row_dimensions{row{1} + shift_row }.outlineLevel  = sheet.row_dimensions{row{1}}.outlineLevel;
                    sheet.row_dimensions{row{1} + shift_row }.r             = sheet.row_dimensions{row{1}}.r;
                    sheet.row_dimensions{row{1} + shift_row }.s             = sheet.row_dimensions{row{1}}.s;
                    sheet.row_dimensions{row{1} + shift_row }.spans         = sheet.row_dimensions{row{1}}.spans;
                    sheet.row_dimensions{row{1} + shift_row }.style_id     = sheet.row_dimensions{row{1}}.style_id;
                    sheet.row_dimensions{row{1} + shift_row }.thickBot      = sheet.row_dimensions{row{1}}.thickBot;
                    sheet.row_dimensions{row{1} + shift_row }.thickTop      = sheet.row_dimensions{row{1}}.thickTop;
                    sheet.row_dimensions{row{1} + shift_row }.visible       = sheet.row_dimensions{row{1}}.visible;
                end
             end
             
             % コピー先がマージセルでなければ値をコピー。
             if ~isa(sheet.cell(row{1},col{1}),'py.openpyxl.cell.cell.MergedCell')
                sheet.cell(row{1} + shift_row,col{1} + shift_col).value = ...
                    sheet.cell(row{1},col{1}).value;

                sheet.cell(row{1} + shift_row,col{1} + shift_col).hyperlink = ...
                    sheet.cell(row{1},col{1}).hyperlink;
                 
                sheet.cell(row{1} + shift_row,col{1} + shift_col).comment = ...
                    sheet.cell(row{1},col{1}).comment;

                sheet.cell(row{1} + shift_row,col{1} + shift_col).number_format = ...
                    sheet.cell(row{1},col{1}).number_format;

                % 書式があったら、書式もコピー。
                if sheet.cell(row{1},col{1}).has_style
                    style_obj = py.openpyxl.styles.proxy.copy(sheet.cell(row{1},col{1}).font);
                    sheet.cell(row{1} + shift_row,col{1} + shift_col).font = style_obj;

                    style_obj = py.openpyxl.styles.proxy.copy(sheet.cell(row{1},col{1}).border);
                    sheet.cell(row{1} + shift_row,col{1} + shift_col).border = style_obj;

                    style_obj = py.openpyxl.styles.proxy.copy(sheet.cell(row{1},col{1}).fill);
                    sheet.cell(row{1} + shift_row,col{1} + shift_col).fill = style_obj;

                    style_obj = py.openpyxl.styles.proxy.copy(sheet.cell(row{1},col{1}).protection);
                    sheet.cell(row{1} + shift_row,col{1} + shift_col).protection = style_obj;

                    style_obj = py.openpyxl.styles.proxy.copy(sheet.cell(row{1},col{1}).alignment);
                    sheet.cell(row{1} + shift_row,col{1} + shift_col).alignment = style_obj;


                end
             end
        end
    end

    %解除した結合セルの結合を戻す
    for merged_cell = merged_cells
        if merged_cell{1}.min_row >= min_row && ...
           merged_cell{1}.min_col >= min_col && ...
           merged_cell{1}.max_row <= max_row && ...
           merged_cell{1}.max_col <= max_col

            % コピー先のセルの結合する
            sheet.merge_cells(merged_cell{1}.coord);
            
            % コピー先のセルの結合範囲情報を作成する。
            newCellRange = py.copy.copy(merged_cell{1});
            
            % コピー先のセルの結合範囲情報をずらす。ここではshiftRow分ずらしている。
            newCellRange.shift(shift_col, shift_row);
            
            % コピー先のセルの結合する。
            sheet.merge_cells(newCellRange.coord);

        end
    end
    
end