Redmine 検証環境 (vagrant-redmine)
===========================

Vagrant + Ansible で Redmine の検証環境をローカルに構築するリポジトリです。  
Debian 13 の仮想マシン上に、  
Redmine 本体と周辺サービス(Web サーバー、データベース、メール、監視)を一式セットアップします。

Redmine 本体の動作検証、プラグインの検証、wikiや  
チケットテンプレートなどのコンテンツ検証を目的としています。

構築される環境
---------------------------

| コンポーネント | 内容                                            |
| -------------- | ----------------------------------------------- |
| Redmine        | 7.0-stable(`redmine_version` で変更可)          |
| ミドルウェア   | Nginx / MariaDB / Redis / Sidekiq               |
| メール         | OpenDKIM、SpamAssassin、mailpit(受信テスト用)   |
| TLS            | dehydrated                                      |
| 監視・運用     | Mackerel agent、logrotate、backup、glances など |

検証用のコンテンツもリポジトリ内で管理しています。

- `provision/files/wiki/` — Redmine wiki のページ一式
- `provision/files/template/` — チケットテンプレート(ADR / 要件定義 / バグ など)
- `provision/files/attachment/` — 添付ファイルのサンプル

必要なもの
---------------------------

- VirtualBox(Apple Silicon では arm64 版)
- Vagrant 2.4 以降
- Vagrant box `debian-13`(別リポジトリでビルドしたイメージ。末尾の「ベースボックス」を参照)
- Ansible 2.21 以降(`vagrant up` を実行するホスト側で必要)
- 任意: `vagrant-hostsupdater` プラグイン(`/etc/hosts` にホスト名を自動登録)
- 任意: `task`(タスクランナー)、`direnv`(`bin/` を `PATH` に追加)

クイックスタート
---------------------------

```bash
vagrant up    # 初回は box の取得とプロビジョニングで 20〜40 分程度
vagrant ssh   # 仮想マシンへログイン
```

| 用途    | URL                    |
| ------- | ---------------------- |
| Redmine | http://localhost:8080/ |
| mailpit | http://localhost:8025/ |

`vagrant-hostsupdater` を入れている場合は、以下のURLでもアクセスできます。

- http://redmine.local/
- http://mailpit.redmine.local/

### 仮想マシンの構成

| 項目                     | 値                                                     |
| ------------------------ | ------------------------------------------------------ |
| box                      | `debian-13`                                            |
| メモリ / CPU             | 4096 MB / 4                                            |
| プライベートネットワーク | `192.168.33.101`                                       |
| ポートフォワード         | 80 -> 8080、8025 -> 8025、22 -> 2222                   |
| ホスト名                 | `redmine.local`(環境変数 `VAGRANT_VM_DOMAIN` で変更可) |

プロビジョニング
---------------------------

`vagrant up` 時に Ansible が 3 段階で実行されます。

1. `provision/playbook.yml` — 環境構築
2. `provision/verify.yml` — 構築結果の検証(`provision/verify/*.yml`)
3. `provision/report.yml` — 構築レポートの生成

ロールは `provision/requirements.yml` の定義に従い、ansible-galaxy が
`.vagrant/provisioners/ansible/roles` へ取得します(`wate/ansible-role-*` リポジトリ)。

| ロール                     | 役割                             |
| -------------------------- | -------------------------------- |
| `common`                   | 基本設定、パッケージ、GeoIP など |
| `nodejs`                   | Node.js                          |
| `opendkim`                 | DKIM 署名                        |
| `mariadb`                  | データベースとユーザー作成       |
| `redis`                    | Redis                            |
| `dehydrated`               | TLS 証明書                       |
| `nginx`                    | Web サーバー                     |
| `redmine`                  | Redmine 本体、プラグイン、テーマ |
| `tools`                    | 運用ツール                       |
| `logrotate` / `backup`     | ログローテーション、バックアップ |
| `mackerel_agent`           | 監視エージェント                 |
| `spamassassin` / `mailpit` | メール検証用(ローカル環境向け)   |

再構築は `vagrant provision` です。特定のロールだけを実行する場合は、  
`provision.yml` の`tags` にロールタグ(例: `role_redmine`)を指定します。

設定
---------------------------

### provision.yml

リポジトリ直下の `provision.yml` でプロビジョニングの挙動を制御します。  
書式は`provision.sample.yml` を参照してください。

| キー                                                | 内容                                                |
| --------------------------------------------------- | --------------------------------------------------- |
| `role_update`                                       | ansible-galaxy でロールを取得し直すか(既定: `true`) |
| `pre_task.update_cache` / `pre_task.update_package` | 事前の apt update / upgrade の可否                  |
| `tags` / `skip_tags`                                | 実行するロールの絞り込み                            |
| `extra_var`                                         | Ansible に追加で渡す変数                            |
| `raw_arguments`                                     | `ansible-playbook` に直接渡す引数(例: `--diff`)     |

### 変数

- `provision/group_vars/all.yml` — ドメイン、Redmine のバージョン、インストールするプラグインとテーマ、
  `configuration.yml`、データベース、Sidekiq、wiki やテンプレートの投入可否、
  再インポート用フラグ(`redmine_reimport_*`)など
- `provision/host_vars/<host>.yml` — ホスト固有の変数

### カスタムスクリプト

`provision/custom_scripts/*.sh.j2` は `~/bin` に配備されます。

| スクリプト         | 内容                       |
| ------------------ | -------------------------- |
| `db-optimize`      | データベースの最適化       |
| `db-doc`           | スキーマドキュメントの生成 |
| `snapshot-save`    | スナップショットの保存     |
| `snapshot-list`    | スナップショットの一覧     |
| `snapshot-restore` | スナップショットの復元     |
| `snapshot-delete`  | スナップショットの削除     |

タスクランナー
---------------------------

`Taskfile.yml` には VPS / クラウド向けのタスク(Terraform と Ansible を直接実行する構成)が
定義されています。

```bash
task build    # ansible-playbook playbook.yml
task verify   # ansible-playbook verify.yml
task report   # ansible-playbook report.yml
```

`create` / `destroy` は `main.tf` が存在する場合のみ実行できます。  
ローカル検証環境では、これらのタスクではなく `vagrant` コマンドを使用してください。

ディレクトリ構成
---------------------------

```text
Vagrantfile              仮想マシンの定義とプロビジョニングの組み立て
provision.yml            プロビジョニングの挙動(provision.sample.yml が雛形)
provision/
  playbook.yml           環境構築
  verify.yml             検証(verify/ 配下の個別チェックを読み込む)
  report.yml             レポート生成
  requirements.yml       ansible-galaxy で取得するロール
  ansible.cfg            Ansible の設定
  group_vars/            共通変数
  host_vars/             ホスト固有変数
  files/                 wiki、チケットテンプレート、添付ファイル
  custom_scripts/        仮想マシンへ配備する運用スクリプト
  vagrant_trigger/       Vagrant の up / provision / halt / destroy フック
  roles/                 このリポジトリ固有のロール
  templates/             フォントや CSS などのテンプレート
  verify/                検証項目ごとの Playbook
  report/                レポート定義
docs/
  schema/                Redmine のデータベーススキーマ(tbls で生成)
bin/                     補助スクリプト
```

ドキュメント
---------------------------

`docs/schema/` は tbls(https://github.com/k1LoW/tbls)で生成したデータベーススキーマです。  
`.tbls.yml` の接続先を構築済みの MariaDB に向けたうえで再生成できます。

```bash
tbls doc        # docs/schema を更新
mkdocs serve    # http://127.0.0.1:8000 で確認
```

`bin/normalize_help_wiki_links.sh` は、`provision/files/wiki/help` 配下の Markdown リンクを  
Redmine wiki 記法へ正規化します。

トラブルシュート
---------------------------

- `vagrant-hostsupdater` が sudo パスワードを要求する場合: `/etc/hosts` に手動で追記するか、
  環境変数 `VAGRANT_HOSTSUPDATER_PATH` で書き込み先を変更してください。
- 仮想マシンを作り直す場合: `vagrant destroy -f` のあと `vagrant up` を実行します。
- box を更新する場合: `vagrant box update`。

ベースボックス(VM イメージ)
---------------------------

`Vagrantfile` の `config.vm.box = 'debian-13'` は、このリポジトリ内では定義していません。  
イメージ自体は次のリポジトリでビルドしており、ローカルに登録された box を参照します。

- https://github.com/wate/vagrant-boxes

なお `config.vm.box` の `debian-13` はベースイメージ(box)の名前で、  
VirtualBox 上に作成される仮想マシン名とは別です。
仮想マシン名はプロバイダ設定の `vb.name` で指定しており、現在は `redmine` です。

| 項目       | 内容                                                  |
| ---------- | ----------------------------------------------------- |
| ビルド方式 | 公式 Debian ISO からの preseed インストール(Packer)   |
| 対象       | Debian 13 (trixie)、arm64、VirtualBox                 |
| 登録名     | `debian-13`(ローカル登録のため box の version は `0`) |
| 生成物     | `package.box` と、ビルド情報を記録した `metadata.yml` |

ビルドは vagrant-boxes 側で行います(VirtualBox / Packer / Vagrant が必要です)。

```bash
packer build -force debian-13.pkr.hcl   # ビルド後に debian-13 として自動登録される
vagrant box list                        # debian-13 が登録されていることを確認
```

ビルド後は `prepare.yml` / `verify.yml` により、ディストリビューションのバージョンと  
アーキテクチャが `metadata.yml` の値と一致するか検証できます。
box を更新した場合は、このリポジトリ側で `vagrant destroy -f` のあと  
`vagrant up` を実行して作り直してください。
