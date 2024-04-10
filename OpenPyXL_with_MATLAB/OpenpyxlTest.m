function OpenpyxlTest()

    % オブジェクト、関数のヘルプを参照する場合
    % py.help(xbook.get_sheet_names)

    %WorkBook
    xbook = py.openpyxl.load_workbook('SampleFile.xlsx');
    %xbook = py.openpyxl.load_workbook('torihiki.xlsx');
    
    
    %Workbookの使い方
    %シートの選択
    sheet1 = xbook.worksheets{1};                    %プロパティでシート選択する場合
    %sheet2 = xbook.get_sheet_by_name('Test') ;    %シート名を指定して取得する場合

    %シートの作成
    sheet3 = xbook.create_sheet('Create', int32(1));

    %workbook.index(worksheet ) WorkSheetオブジェクトを渡すとIndex番号を返す
    %idxNo = xbook.index(sheet2);
    
    %シート名のリスト
    sheetList = xbook.get_sheet_names();
    
    
    %シートの操作
    %セル結合
    sheet3.merge_cells("A1:E4")
    sheet3.unmerge_cells("A1:E4")
    
    %セルに値を代入
    cell_a = sheet3.cell(int32(1),int32(1),1);
    cell_b = sheet3.cell(int32(2),int32(1),"ABC");

    % A1:A1を表示する
    sheet3.calculate_dimension

    %書式
    cell_a.number_format = "0.0";
    
    %セルの値を書き換え
    cell_a.value = 123.456;

    %ハイパーリンク
    cell_b.value = cell_b.value + "cdef";  
    cell_b.hyperlink = "https://www.amazon.co.jp/";
    
    cell_c = sheet3.cell(int32(5),int32(3));
    cell_c.value = '=HYPERLINK("https://www.amazon.co.jp/", "Amazon")';
    
    %フォントを変える
    styl_font_hyplnk = py.openpyxl.styles.Font(pyargs('color','0000EE','underline','single'));
    cell_c.font = styl_font_hyplnk;
    
    %セルの高さ、幅を変更する
    %セル幅の変更
    colNo = py.openpyxl.utils.cell.get_column_letter(2);
    sheet3.column_dimensions{colNo}.width = 30;
    
    colNo = py.openpyxl.utils.cell.get_column_letter(5);
    sheet3.column_dimensions{colNo}.width = 30;
    
    %セルの高さ変更
    sheet3.row_dimensions{5}.height  = 30;
    
    
    %セル背景色
    styl_fill_NG = py.openpyxl.styles.fills.PatternFill(pyargs('patternType','solid','fgColor','ff3333'));
    cell_c.fill = styl_fill_NG;
   
    %セルの罫線を変更
    %線の種類
    style_Side = py.openpyxl.styles.borders.Side(pyargs('style','thin','color','000000'));
    style_border = py.openpyxl.styles.borders.Border(pyargs('left',style_Side,'right',style_Side,'top',style_Side,'bottom',style_Side));
    cell_b.border = style_border;
    
    
    %レンジ
    for row = cell(py.tuple(sheet1.iter_rows(pyargs('min_row',int32(2),'values_only',false))))
        for col = cell(row{1})
             if ~isa(col{1},'py.openpyxl.cell.cell.MergedCell')
                disp(col{1}.value);
             end
        end
    end

    shTEST = xbook.get_sheet_by_name('Test') ;    %シート名を指定して取得する場合
    
    T_max_row = shTEST.max_row;
    T_max_col = shTEST.max_column;
    T_min_row = shTEST.min_row;
    T_min_col = shTEST.min_column;
    
    %Cellコピー
%     loop_row=0;
%     loop_col=0;
    cp_dest_row = 2;
    cp_dest_col = 20;
    
    oxRangeCellCopy(shTEST,2,2,30,19,cp_dest_row,cp_dest_col);

%     cell_b = shTEST.cell(int32(2),int32(1),"ABC");
%     cell_b.hyperlink = "https://www.amazon.co.jp/";

%     for row = cell(py.tuple(sheet1.iter_rows(pyargs('min_row',int32(2),'min_col',int32(9),'max_row',int32(28),'max_col',int32(9),'values_only',false))))
%         for col = cell(row{1})
%             disp(col{1}.value);
%             shTEST.cell(int32(cp_dest_row + loop_row),int32(cp_dest_col + loop_col)) = col{1};
%             loop_col = loop_col + 1;
%         end
%         loop_row = loop_row + 1;
%         loop_col=0;
%     end
    
    % utils cell
    % absolute_coordinate 'B3' ⇒ '$B$3'
    aa = py.openpyxl.utils.cell.absolute_coordinate('B5');
    
    % cols_from_range A1:B3 ⇒ [1] ('A1', 'A2', 'A3')
    %                          [2] ('B1', 'B2', 'B3')
    aa = py.openpyxl.utils.cell.cols_from_range('A1:B3');
    
    % column_index_from_string 'B' ⇒ 2
    aa = py.openpyxl.utils.cell.column_index_from_string('B');
    
    % coordinate_from_string 'B3' ⇒ ('B', 3)
    aa = py.openpyxl.utils.cell.coordinate_from_string('B3');
    
    % coordinate_to_tuple    A2 ⇒ (2, 1)
    aa = py.openpyxl.utils.cell.coordinate_to_tuple('A2');
    
    % get_column_interval ('A', 'C') ⇒ ['A', 'B', 'C']
    %                         (4, 6) ⇒ ['D', 'E', 'F']
    %list_start_end = {['A', 'C'], ['B', 4], [3, 'E'], [4, 6], [4, 27]};
    %for list = list_start_end
    %    aa = py.openpyxl.utils.cell.get_column_interval(list);
    %end
    % get_column_letter         2 ⇒ 'B'
    aa = py.openpyxl.utils.cell.get_column_letter(2);
    
    % quote_sheetname  "Sheet X" ⇒ "'Sheet X'"
    aa = py.openpyxl.utils.cell.quote_sheetname("Sheet X");
    
    % range_boundaries A2:C4 ⇒ (1, 2, 3, 4)
    aa = py.openpyxl.utils.cell.range_boundaries("A2:C4");
    
    % range_to_tuple SheetX!A2:C4 ⇒ ('SheetX', (1, 2, 3, 4))
    aa = py.openpyxl.utils.cell.range_to_tuple("SheetX!A2:C4");
    
    % rows_from_range               A1:B3 ⇒
    %                                        [1] ('A1', 'B1')
    %                                        [2] ('A2', 'B2')
    %                                        [3] ('A3', 'B3')
    caa = py.openpyxl.utils.cell.rows_from_range("A1:B3");
    
    %save
    xbook.save('sample_out2.xlsx');
    
    %close object
    xbook.close();
    %close(xbook);
end