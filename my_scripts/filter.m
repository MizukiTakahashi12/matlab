% データ読み込み
data = readtable('ADCP_both.csv', 'ReadVariableNames', true, 'VariableNamingRule', 'preserve');

% 鉛直レイヤー数
num_layers = 24;

% 条件に一致した行を格納するためのテーブル
filteredData = [];

% 各行を確認
for t = 1:height(data)    

    % 流速データのうちmagnitude部分を抽出（深い方から浅い方への並びに注意）
    magnitude = double(table2array(data(t, 33:-1:10)))';  % 24層の流速
    
    % 条件チェック：10層目～23層目（インデックス的には10:23）
    if any(magnitude(10:23) >= 50)
        % 条件に合致する行を追加
        filteredData = [filteredData; data(t, :)];
    end
end

% 結果をCSVに書き出し
writetable(filteredData, 'filtered_rows.csv');
