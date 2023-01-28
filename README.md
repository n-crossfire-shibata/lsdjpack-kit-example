## 必要なもの

Docker git

## 準備

事前に Dockerfile が置いてあるディレクトリに

```
git clone --recursive git@github.com:rondnelson99/lsdpack-kit.git
```

で lsdjpack-kit のディレクトリを作る
git の鍵認証ができない場合は https でやれば問題なし

変更が必要なファイルは lsdjpack-kit/src/res の中に入れておく
コンテナを作る時にコピーされるので事前にやっておくこと、もし後からファイルを変更したい場合は適宜 `docker cp` で
注意として**絶対に**ホストの OS では make しないこと
コンパイラのバージョンが異なる lsdjpack のバイナリが作られて動作しなくなります

## 使い方

Dockerfile が置いてあるディレクトリで

```
docker build . -t debian
```

`debian` の部分はすでに同じ名前を使ってて困るという場合適宜書き換え

ビルド成功したら

```
docker run -itd debian
```

次に

```
docker ps
```

でコンテナの ID を調べる

```
CONTAINER ID   IMAGE     COMMAND   CREATED       STATUS       PORTS     NAMES
6cdbbe0ce9db   debian    "bash"    2 hours ago   Up 2 hours             unruffled_almeida
```

こんな感じの値が出力されるので `CONTAINER ID` の部分をコピーしてコンテナの bash を開く
以下、コンテナの ID は `6cdbbe0ce9db` だった前提のコマンド

```
docker container exec -it 6cdbbe0ce9db bash
```

ログインしたら

```
cd /work/lsdpack-kit
make
```

を実行すると、うまく動けば `/work/lsdpack-kit/bin` に `lsdpack.gb` が作られているので、これを docker cp で持ってくる
ここもコンテナの ID を指定する
`/path/to/host` には保存したいホスト OS 側のパスを書くこと

```
docker cp 6cdbbe0ce9db:/work/lsdpack-kit/bin/lsdpack.gb /path/to/host
```

使いおわったら以下のコマンドでコンテナを停止する
ここもコンテナの ID を指定する

```
docker stop 6cdbbe0ce9db
```

## 注意点

使い捨て環境なので割とゴリゴリ自分でコマンドを打つ前提です
頑張れば改良できるところは多そう

なにかおかしいなと思ったら以下のコマンドで全てを消去してやり直し

```
docker system prune -a
```
