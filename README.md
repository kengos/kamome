# Kamome

[![Build Status](https://travis-ci.org/kengos/kamome.svg?branch=master)](https://travis-ci.org/kengos/kamome)

日本郵便の郵便番号データの取得を行うインターフェースです

以下のように block を渡すことで 郵便番号データ の取り込みで任意の実装を行うことができます

```rb
Kamome.import_general_all do |model, lineno|
  puts "#{lineno}: #{model.zipcode} => #{model.prefecture}#{model.city}#{model.town}"
end
```

対応CSV

* 全国一括 (全件, 差分)
* 事業所(全件, 差分)

各CSVは共通のモデルにマッピングされます(type オプションで詳細なモデルに変更可能)

詳細は [Kamome::Models::Address](https://github.com/kengos/kamome/blob/master/lib/kamome/models/address.rb) を参照してください

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kamome'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kamome

## Usage

### 全国一括の郵便番号データの取り込み

```rb
Kamome.import_general_all do |model, lineno|
  puts "#{lineno}: #{model.zipcode} => #{model.prefecture}#{model.city}#{model.town}"
end
```

### 全国一括の郵便番号データの取り込み(差分)

```rb
date = Time.local(2018, 11) # 2018/11 更新分の取り込み
Kamome.import_general_diff(date: date) do |model, lineno|
  if model.update?
    puts "追加データ: #{model.zipcode} => #{model.prefecture}#{model.city}#{model.town}"
  else
    puts "削除データ: #{model.zipcode} => #{model.prefecture}#{model.city}#{model.town}"
  end
end
```

### 事業所の郵便番号データの取り込み

```rb
Kamome.import_jigyosho_all do |model, lineno|
  puts "#{lineno}: #{model.zipcode} => #{model.prefecture}#{model.city}#{model.town}"
end
```

### 事業所の郵便番号データの取り込み(差分)

```rb
date = Time.local(2018, 11) # 2018/11 更新分の取り込み
Kamome.import_jigyosho_diff(date: date) do |model, lineno|
  if model.update?
    puts "追加データ: #{model.zipcode} => #{model.prefecture}#{model.city}#{model.town}"
  else
    puts "削除データ: #{model.zipcode} => #{model.prefecture}#{model.city}#{model.town}"
  end
end
```

## FAQ

### `Kamome.import_xxx` の model の型を変換したい

#### DetailModel にする場合

```rb
Kamome.import_general_all(type: :detail or Kamome::Operation::TYPE_DETAIL)
# 通常の戻りの型である `Kamome::Models::Address` ではなく以下のモデルで返却されます
#   事業所CSV の場合 `Kamome::Models::Jigyosho`
#   通常のCSV の場合 `Kamome::Models::General`
```

## データのクリーニングについて

### 通常のCSV

#### `Kamome::Models::General#town` or `Kamome::Models::Address#town`

|元データ|変換後|備考|
|--------|------|----|
|以下に掲載がない場合||空白になります|
|XXXXXの次に番地がくる場合||空白になります|
|XXXXX（YYYY階）|XXXXX（YYYY階）|元の値を維持しています|
|XXXXX（YYYYY）|XXXXX|() の部分が除去されます|

※ 以下のような削除データが発生する可能性があり、 `town` が正確に取得できないことがあります

```
26106,"600  ","6008093","ｷｮｳﾄﾌ","ｷｮｳﾄｼｼﾓｷﾞｮｳｸ","ﾀｹﾔﾁｮｳ","京都府","京都市下京区","竹屋町（高倉通綾小路下る、高倉通仏光寺上る、堺町通綾小路下",0,0,0,0,2,6
26106,"600  ","6008093","ｷｮｳﾄﾌ","ｷｮｳﾄｼｼﾓｷﾞｮｳｸ","ﾀｹﾔﾁｮｳ","京都府","京都市下京区","る西入）",0,0,0,0,2,6
```

#### `Kamome::Models::General#town_kana`

|元データ|変換後|備考|
|--------|------|----|
|イカニケイサイガナイバアイ||空白になります|
|XXXXXノツギニバンチガクルバアイ||空白になります|
|XXXXX(Yカイ)|XXXXX(Yカイ)|元の値を維持しています|
|XXXXX(YYYYY)|XXXXX|() の部分が除去されます|

### 事業所CSV

#### 私書箱情報について

`Kamome::Models::General#post_office_box` or `Kamome::Models::Address#post_office_box`

`０丁目０番地（ああああ郵便局私書箱第０００号）` のようなデータが有った場合

* post_office_box ... `ああああ郵便局私書箱第０００号`
* street ... `０丁目０番地`

として設定されます

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `make` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kengos/kamome.
